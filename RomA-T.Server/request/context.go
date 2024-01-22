package request

import "context"

func FromContext(ctx context.Context) *Request {
	req, ok := ctx.Value("request").(*Request)
	if !ok {
		return nil
	}
	return req
}
