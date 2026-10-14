Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35F13A7F51
	for <linux-perf-users@vger.kernel.org>; Wed, 14 Oct 2026 05:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791956343; cv=pass; b=hnqKZR0EWYD8JpB465apDRXjxoq/UzayqVAReB1F6XZqC9xullfyavAtAb1On5HZAFPHnQyg192p2QXNZS/qgkK7FXwO7W/GQ65W8HQHVz+XQ+6NJQdIDmS9byUSMX4wfS74A8ASwZ7pZjOHBaaJg7oQc6wfG9Av/iZYM+b3tOA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791956343; c=relaxed/simple;
	bh=sQnTAsWHq4+55jfadbIHEQA+SgOqiqsLpP2v7YshXgs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RUrAvqGUbhpmiYllkvlAT/4rvPdyenqrTYGg02Ojuaf5aFXRtwk0oNcBNJAlhYBS6uUezvCrKf71QrXketqn1ebeJ71PyhFpJkSJsn6GPEItyMBbuhWNjIjvqqxn3RAMIxNWe1jJodEbLIjEx4p7b4c76pRN5u5wB36TYxVxNpk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AUt9BX+F; arc=pass smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AUt9BX+F"
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-154e9d2d979so402923c88.1
        for <linux-perf-users@vger.kernel.org>; Tue, 13 Oct 2026 22:39:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791956341; cv=none;
        d=google.com; s=arc-20260327;
        b=ZC5ucVox58vz061WSmWjsljV/Q4jChAa65CvndwLB8JnM7qG3JWmkejn6Mp9BN3nKL
         0Es6j9UmcmtQz4t6UxmF8W/qHRnr0M4C/GEwaxXmrHtqrF8Dc1IDKgUnv2mryVvXeeqn
         Q8soh9Lo3XxtrREzHERHEbnqJSewoHbN2pg8z6TaWCla5bC2VVFH18APp/8/l7ITmP1F
         jwv97Bkboz522YNgCJK2uXmio830AJ9eCsm/l0n7RRgaxyki8PiJ9Ho+K6TeQLMa0Z7h
         plG6qPS+DE6FK2O6kxcVQRWhU4XtLEm5CZzKx7ksT9fOdppKEr6uZr1GoqPvGZjUST+a
         DjXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=x6VJRMtY6hAHANq9F08XUEKM+7gNdB2F6gizUc3NuJ0=;
        fh=wVcurifjPd4iHxIQ52ONWkcUyI9kMX9oAp3sFmCAF6w=;
        b=YqkRQTYuvooXL5fafenGy5278PGfz+aedYY6OmVB/wMECtF+xYjzGQNjgXRqQsgcsk
         bkpwkP2+QXNAG+QAFBJTQJ7Ol43AQh1daGQo++p16PFZZCdDmA6j8DSzChZ/ellkbva7
         /dMUu9TnzOug8N6q1Q4nICCXFi9dAcaCRZcyVl2r9kv1gqwhdUlm+qJ928evS5xYd+IJ
         F7eWyB4UBg0bBtZV4XAxxWeX96PiaHrULYFUGlPjX6BNCOuWadqYSR03wCBUCfJpBQu+
         pB1DCksjwyHb9jhBLpjOkjue13B6Uss6Qx52UpqXRagw/GNP7Jq7O2C/fdOBktX1lQdN
         KzVA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791956341; x=1792561141; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=x6VJRMtY6hAHANq9F08XUEKM+7gNdB2F6gizUc3NuJ0=;
        b=AUt9BX+F4pwLcSsUuOXT+0bvdCx5qVwz+nb9q+U9AmGIhxDBXAkwvtzOttvxinJdYe
         ++rFN8aq4CX4s2C9UozB1OOH4oBh6rmWripwRj/igDF5GZDgmmCCmqhUrurn7jsgGvQt
         ZdCj+oMy/x02IxMD3fEantnHg5BtWJ3YWYF882n79PUX0oIpvCsiWSCN1wrGdCwJNfmF
         644a5QIf//KQKOl6TMI1E2grrZv3kcLzBXx4VF89BaQL1xT6yJ3jqbBycxFOXt7G8TFb
         UjsODva+gJ2uj2M+VxafaDsVo1G3Z1tRcuror1UmhNzVh2IyLqGYcDwhtVIA/Z2l7dus
         ESgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791956341; x=1792561141;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=x6VJRMtY6hAHANq9F08XUEKM+7gNdB2F6gizUc3NuJ0=;
        b=yXCNGb/6Fz3/ycbZ/TZ3S3m3bMkjf//XxIsrrg+MMsnlSajY1drHnBd7jBmoLTo5AD
         G+seYZg5vPbilhPn8S60KKA/h183AS8yL95tvifbeYAWb2+PZADSz74WGj88M5edTBNi
         JA/R4ejc+vxJG+04ply86j/jUz1qMpWjJ65/7rILlnzWLuVis16AXHOokjSzWGO0NNj4
         tt1ASl9mGCCP7qU70J1m2sE9Qzg092k6FV8/Tim0H1CL2jSWLP9nHwXCYC6epvH4TWAo
         z7G56BQ4PBFGx8MdteypzYqFUO5Nmhlu82qgLctQHl7okvEfuNlMihnlV6o81bFE76Cn
         q8PA==
X-Forwarded-Encrypted: i=1; AKwUvBzMNXcO9A7rkbu2vWEhp2XLLNtroSdi2Dr52ACpZqUTURJhX2o1GBSKLnDED8SnIpqJ9yz3wOipPVOvHltjrGbN@vger.kernel.org
X-Gm-Message-State: AFq9FYL5L8Ma0lkfaix7pArYNWkRzTCgYDAp7EZlgcNz8B1oYtA0V0Fk
	r8Uw0A0sS3/GS54y9I1VVGeyNqNvUHZjSnNrmIWdStoSTrbcs9pKm30BsUkdRC1SH9o5OroinCe
	/U50wQqWTpvbLZ22SDgMZPW6rj5xzrbRS34pgYZ7A
X-Gm-Gg: AYBFou3RbQ0ocE3AH4TpPZxPienB3Eus5yEQIh0eT5qdAR5me7ilaO7THG/EL73TzNm
	X6iYBGIv65LSD7T5AM0gqxfMZAObD7W0t/FYt7uK8PluwpnwIRGlWd6S73kzfym1AnZVlYZnqRu
	yWrBYjgpV1WMS08Cyxjt+NCAzHO3W2cCfxEXSRIEG82UGBaY5XUhndwMj6vsjafsGR/2ykroBcA
	1nzdjz9l4zrOsvG76xbhV/zYSkB71NccSHtAUWXxZAipmtTkBWCtx4lIDQv11aMjqnJX0EohdPF
	B8wYpS+UchjV46vTSgvsDp7ctlconf//TwcqBqixIv5TqtkBHOkkWfhWSzD7F+5DfrQZR4+IOoP
	4pl4T8UkeQSE=
X-Received: by 2002:a05:701b:280e:b0:13c:d071:f97c with SMTP id
 a92af1059eb24-16a5b97ae60mr20506478c88.11.1791956340159; Tue, 13 Oct 2026
 22:39:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261013182458.1234616-1-irogers@google.com> <20261013222622.1822619-1-irogers@google.com>
 <20261013222622.1822619-2-irogers@google.com>
In-Reply-To: <20261013222622.1822619-2-irogers@google.com>
From: Marco Elver <elver@google.com>
Date: Wed, 14 Oct 2026 07:38:23 +0200
X-Gm-Features: AclHuK-RqXDABlGb5HhgbEpeIBMyScVO6dFeQyQpd9-tIjzH7Wv_4SxQF0fb1yA
Message-ID: <CANpmjNP=4T4pRpoiW_Y442KQbWyVtECUD3_SYs5ZYrdwkWh2rQ@mail.gmail.com>
Subject: Re: [PATCH v2 01/10] compiler-context-analysis: Avoid unused
 parameter warning in _context_unsafe_alias()
To: Ian Rogers <irogers@google.com>
Cc: acme@kernel.org, namhyung@kernel.org, adrian.hunter@intel.com, 
	bvanassche@acm.org, james.clark@linaro.org, jolsa@kernel.org, 
	justinstitt@google.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, ljs@kernel.org, llvm@lists.linux.dev, 
	mingo@redhat.com, morbo@google.com, nathan@kernel.org, 
	ndesaulniers@google.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 14 Oct 2026 at 00:26, Ian Rogers <irogers@google.com> wrote:
>
> _context_unsafe_alias() does not use its parameter 'p', which triggers
> -Wunused-parameter when building code that enables -Wextra (such as
> tools/perf, tools/lib/perf, tools/lib/subcmd, and tools/lib/symbol).
> Explicitly cast 'p' to void to silence the warning, matching
> __assume_ctx_lock() and __assume_shared_ctx_lock().
>
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Reviewed-by: Marco Elver <elver@google.com>

Re __attribute__((unused)): I suppose it could work, but (void)p is
the more minimal solution that is not uncommon across the kernel. I
don't see a downside, and less code is better.

Thanks!

> ---
>  include/linux/compiler-context-analysis.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/compiler-context-analysis.h b/include/linux/compiler-context-analysis.h
> index 8302ebc2ea8c..024e303188ad 100644
> --- a/include/linux/compiler-context-analysis.h
> +++ b/include/linux/compiler-context-analysis.h
> @@ -243,7 +243,7 @@
>   * alias as a function argument).
>   */
>  #define context_unsafe_alias(p) _context_unsafe_alias((void **)&(p))
> -static inline void _context_unsafe_alias(void **p) { }
> +static inline void _context_unsafe_alias(void **p) { (void)p; }
>
>  /**
>   * token_context_lock() - declare an abstract global context lock instance
> --
> 2.56.0.385.gd3acb90ef8-goog
>
