Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 165B5413D78
	for <linux-perf-users@vger.kernel.org>; Fri, 15 May 2026 19:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778874035; cv=pass; b=I4Z8z8CbflQfDGBjsOPd1/rIgEUyXxT5Bgoj9CKcAAPKSt+kdldZzJoc4Qi7+ZVG8Pa7cU0E/LH+DtCksgyQh4u8PC2+kuZmfn8pvOGLdgO4sMhH7/AkqyI+DI4YDwAz9jlaIZQcnOQu43GN+IO+z9gKVQkgboPdNhFBbQG+AkM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778874035; c=relaxed/simple;
	bh=YKwe6jSULfstrnXD5pmaH7VOhInZQUPQ48ryfkK9oy0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lgw18UTRxGCSoICQX5VdzSeQ2/FMuUoIJTUeocPwD7HJ+hsSE5utB8AOXf4/dD7Nt7WmSNRfUee1lhjRaDk/jTzp338Ud9cnr5RrU8hKRRjdu+f8Ek5TVOwnzUVaazBMEZSqySdx7VF4JjLqcSB19xCtCOEK0Avnu97r6ndZv5s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Km2ZCvYI; arc=pass smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Km2ZCvYI"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2ba3b9bcf69so1265ad.0
        for <linux-perf-users@vger.kernel.org>; Fri, 15 May 2026 12:40:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778874033; cv=none;
        d=google.com; s=arc-20240605;
        b=HtZVDf+yaz/hCF7iSHYkVmoqlMuy/a8ZLX1XE5TDIS3eZlSPE6buf1G9/FrP7SIdyh
         wXsKDVYejNSbB3VjGafBp3pF60PYcplu8XLVNB0QotMglgSJ0zvHg5b7fWuHShFek+d7
         1XhTnB7G2FItfMF8rOxDGcBvll43OssLKIhSjdaGxgFCUHnK1Nrkh815C22vYo54t62L
         Run+RuFJsTL+uVAFRc38vMG3VG3bqfi86j93bdPbKUag8/QfNXR+RODjDXtOClgTwVyR
         JOQSEpTTQ4Hak9/C36gCqwNh+8MB9PzsEjHPw2rstCl+UDfcba070UIux/psD7Kk9HL5
         NZqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YKwe6jSULfstrnXD5pmaH7VOhInZQUPQ48ryfkK9oy0=;
        fh=4K/q7KxT+nCuyhhBemK8xbrZrgsv8S0tLsakCixVUhs=;
        b=LONeF2WQ3kTzvFRihW0XNIxRNIZQnnJdV8KDyoZiwPj04xTGT8uVVxpE5tfhULLv/z
         /vCN27cVg+ejGDkmyCc4Bo+nttxBTOAMJSRSOR95F92lg268n5A6X1bMjaI4c/bOXoKY
         ir1vodo3I8G3s9VvbitD6rUI9EeL0kfb5O76NFk7QW0SpULILQgQrDQ1EsAgwSyTKcXJ
         p+fIU80tvPT2gZPtQwtEGI5JK+h1ybJ8oQISO5JdP1zoZ9jZL3rGheGtpc1vz/D98w1R
         4ZLeZH/Xn8gJjT4pviD0JTWeBSqQEQNu29pGg5sRDGKzC/A0vN1WVFRzdsUPtOL++hJs
         Ws7Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778874033; x=1779478833; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YKwe6jSULfstrnXD5pmaH7VOhInZQUPQ48ryfkK9oy0=;
        b=Km2ZCvYINIWbOQag45BZVDgLYzBbCoaYqsiRXuXiu5hlxT5NDX8nJT5aE864FVV7jc
         kjTwydiTdyoOgf6rJVv97p9GdeutVd13RYE1kqPjteyxDIp7fyaxXD5hgRdwMkhVbAIW
         gHV1SehEVnaFJP9loafdXjEddo0RS+zo+MdvDvPHAjdkQSLX7uX069JzT1sShFBht6v/
         q8FjhSJmuN+WPq4Lvrhgk0WhkrBIGwgPWjlB9XNFGHwHQ28pj7Y5fVHPBBtbE/0Y2fh4
         nkkztc6tjhZIDBOe2zJK7VZw6O1DzeQQyo5WQ9PH9JyDdFHkdg9b5v+PX8zuFoHYLGC4
         /13Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778874033; x=1779478833;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YKwe6jSULfstrnXD5pmaH7VOhInZQUPQ48ryfkK9oy0=;
        b=cnTC0d1Zoi/UbTw9e0jgG8DQulXrXDMNQsoPGobX8Byng8kQo4YJAY1Wsqlr6RHvsQ
         +7ndS9blpHZ8ZvVfESIWjJCFOSyKqQWIA7lfTkTn2HrpkvJZP632Pc33MMqWBFQLQmCl
         jxHWU0SQmtKfuNpfCq9U071zTi6b+zpjTQWteFpsgossID9KhJoL9+4KinVGUzFGJMwj
         thfOj9eVN1nWUz7jPPKR6240iBHBygylwj4bQmp4C2V9AXOztGGBOqT9zqaKI9DSSFL3
         To+iRTh06gw0kHYfG72RoA2nxDu/rHkU3TH9tORqFMDt1Nob1+B5BfJiNh95p639r9PO
         qKfQ==
X-Forwarded-Encrypted: i=1; AFNElJ/1g4oq/il+wVjb9h5m8ssfkI0tBoHLxyI7TLzXFdnZmeWNjaJb8MH1KyUggV27RUK0q8IZqnl/K5mCx7l8TVj0@vger.kernel.org
X-Gm-Message-State: AOJu0YwLj+ytoqO0she0thcHQ9+z5+rsAQA9Li9Buv73vkJJU6VcdoGg
	+dLIDinx704dLyG+BR/TlXRJjHcAk/4ccypWXE6lxN3Jly9+2qV9QRIVWMuwyljuCd8YZM6nGiE
	wPjcD4k7Q56oFBOoOwiRJi2x/czU52+m4H9CFpGUL
X-Gm-Gg: Acq92OGDmMayHR9tTQwhN3sb6R+64JYJkJZRtC9HdSx7Ml6+fe7PLVaG/FvGkcY3RJ+
	nMBExCujDuhqepbMLGd4G6qzPB5T4/kxjEy9iPI+Rg831Oq73tVBbufk0Pj3Gf66ao8jERvLFX/
	z3pyl0Oc1x0EW/1iexH9jfRAASeKCOh/eKAGBnryhQOavhpmcClJmbfP3AushByKLUBuG6PKD0h
	B314CD8uAiRdXS9fi9PTliahNOyFsOBo5wsMd3JwrYGXu7zEz6638DXe3EKUCvE0BUEs12AoDQu
	71UQ+MXEsd24NZXRRUpA9BAsg2BZgg==
X-Received: by 2002:a17:903:28e:b0:2bd:6dad:3df8 with SMTP id
 d9443c01a7336-2bda0ea389amr433985ad.22.1778874032694; Fri, 15 May 2026
 12:40:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260515180806.246914-1-sigmatwojastara@gmail.com> <20260515181547.99D82C2BCB0@smtp.kernel.org>
In-Reply-To: <20260515181547.99D82C2BCB0@smtp.kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Fri, 15 May 2026 12:40:21 -0700
X-Gm-Features: AVHnY4KI1lrja2wjIoxRnOM6Okw9ETfkCmzYrHCz9L_mjetwnnwff4VNJUH4ucQ
Message-ID: <CAP-5=fUV6W=TBXbCHARMJwm1Pjb4uJCO82EZ3fjU7jsiR51t0w@mail.gmail.com>
Subject: Re: [PATCH] treewide: replace /usr/bin/python3 shebangs with env python3
To: sashiko-reviews@lists.linux.dev
Cc: Oli R <sigmatwojastara@gmail.com>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 15, 2026 at 11:35=E2=80=AFAM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Medium] Commit message states it replaces `#!/usr/bin/python3` shebang=
s and causes no functional changes, but actually changes `#!/usr/bin/python=
` to `#!/usr/bin/env python3` in `tools/perf/tests/shell/lib/perf_json_outp=
ut_lint.py`.
> --
>
> commit 7d3e9689ede53be80434b3ba8cd07c27777d11ad
> Author: Oli R <sigmatwojastara@gmail.com>
>
> treewide: replace /usr/bin/python3 shebangs with env python3
>
> This commit replaces hardcoded /usr/bin/python3 interpreter paths with
> /usr/bin/env python3 to improve portability.
>
> > treewide: replace /usr/bin/python3 shebangs with env python3
> [ ... ]
> > No functional changes intended.
>
> Is this description accurate?
>
> [ ... ]
>
> > diff --git a/tools/perf/tests/shell/lib/perf_json_output_lint.py b/tool=
s/perf/tests/shell/lib/perf_json_output_lint.py
> > index dafbde56cc76f..dccafd507bb79 100644
> > --- a/tools/perf/tests/shell/lib/perf_json_output_lint.py
> > +++ b/tools/perf/tests/shell/lib/perf_json_output_lint.py
> > @@ -1,4 +1,4 @@
> > -#!/usr/bin/python
> > +#!/usr/bin/env python3
>
> Could this affect functionality on systems where python defaults to Pytho=
n 2
> or is managed differently?

The change looks good to me, but I wonder it should be split into
separate patches for the different subsystems. We do not care about
Python 2, so I think some review prompt improvements are necessary.

Thanks!
Ian

> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260515180806.24=
6914-1-sigmatwojastara@gmail.com?part=3D1
>
