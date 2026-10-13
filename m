Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6156D4BA1D3
	for <linux-perf-users@vger.kernel.org>; Tue, 13 Oct 2026 23:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791934032; cv=pass; b=eFWT5IOHycPvdo8l85D/OeJv8JGFOcyyd3nUSbotSbuUkNGf95iCC8ZrV0Om1THL5/2OTa0ofgW4PaDuYoRD39DHKj1lZQvfvNDQYocpo32v10QVPjgd+VRZnMCnpnl76fp4LFF2Q4T5St4gPkMnjiMy9JQOnL3G1nyJOGxWHF4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791934032; c=relaxed/simple;
	bh=HR5rFeE26T8rIbxjxi43O+NmdV5BLspRJkUtyz+T3+U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nfW5SG8SoGDIZLYF4RuRk2FergNs5k3w5tGLeiaYPU4VTRY72BuUFNcefyPhSsX05JWK2M0aQpegJDPALe2xP8qYnQiFLUyBqJA4DHLOwi9+WWQYl2tcqBNjVXnUJvBxNiLOl+UbRImg12nTJ0jMfScw9aY9WqPFJI3TDllqPVo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f4SXfJlP; arc=pass smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f4SXfJlP"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-533202fe429so970551cf.0
        for <linux-perf-users@vger.kernel.org>; Tue, 13 Oct 2026 16:27:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791934030; cv=none;
        d=google.com; s=arc-20260327;
        b=G3OobN2ZUnHgr4cN+brNVJhkgi8JA5/h1zkjE2rlS51r4DIZxtaDPzVRuTGjlvn9Fz
         ubMdVHX8xsrAvGpaN0eUusjG4BQRZSlHZn4SLuROZXqQTKQoPnAc4m0zA2Kvq2tbqwrZ
         flme/mDg2MFOjwi8HGGnDkVnj2dWTG6dGEOMABQlZr0SCDtKi4HFH4b8Y8rAbBfE/vx+
         u374ylwZRm62t8XWe7XfG2FHbMUkgZ/neGiRkdBEPp+fB4I7hqNy39gwUJIhwOa1zHT5
         V9miGOJXj6FEAE+9Prr8k9Hfn7MNqn5QlOUv+F/0t2/2ZaoFcjqQdF+pBnLmsOf61q5A
         8QRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HR5rFeE26T8rIbxjxi43O+NmdV5BLspRJkUtyz+T3+U=;
        fh=yyQtgsPbBqzzMzJqYlg5InmqhH2SplDtELzqwFczAhE=;
        b=R/o5HHEyNVucmecNnrr7mvtvZ4kiqL4hx7WhAAbaSj6KC/1s+bqE1rdolNp+GklBC+
         E2CSrmlPy/GvY/Y7VPXY3U4HoMumB5K2cHz+yUxTq39XRSfCmMKD04ISe35P3Onbt1wD
         Eb7lvVn8uaOd6WycnjMaZy5gKxpYUpWXqP9ICZDq1utFI6ybmkV+XKzxkYtAMP3RRBXs
         ROkH/w0K8E2W1FsFT7nFuSIEfi+MLr6evoPWLZjcGejIzi/oFEl6l5l5rX/lB1Au3fjh
         QjOs34Kcj++8RsRv0hEbd18HS6fUpN3bNeRFfkllfxo1UbNIOf0e5J8YsSSmBvkwVdjm
         hZPA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791934030; x=1792538830; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HR5rFeE26T8rIbxjxi43O+NmdV5BLspRJkUtyz+T3+U=;
        b=f4SXfJlPlI3xhqq3Jjh7JlCygqK2mWqQSKkVHtSk01+iLYp1sxXAZpY7KaWWn4nqKW
         5dKPgoraCKoeCcXTnno7PKJ3kULZ/fuQeNCnOXgoXBYKz4HCbE+X4xT3kGy3IniL/CbV
         fOtluK1LBwlr+lFMd/SrhykiM3zFOfjK4rH0EsCnjXb+a+D+ROv7yOfGJSzlLfJkMxW4
         PMqPKczfYIq5Do/xz85SUHolWl8aYV4VhqiVCQUj50/3t939URoSbnR2srQWt9mreEXR
         SQ/Kq6VOWjSalKdQ8+GCuGlQfCUNJlKsqsa/KkGi2vrPn5LXj1JnsrP+C9BmQQW5Fxid
         tGmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791934030; x=1792538830;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HR5rFeE26T8rIbxjxi43O+NmdV5BLspRJkUtyz+T3+U=;
        b=bvW6gTYc2bhxOqqyBnKOeTRI5uZFDMXFUwCxXgVMFzHHlNFbwxSadSMKDS1zBnv4u7
         mb/1Bgor0XQGzGqEjyRlJh8i6sZF5wVxMZZ+LAID/iDgbyf3HCSypxJyVcRzsMsxeSbT
         NJd+HzwMGPGPRCLgjeJw/9ImW04T4V4s29RQ6/ynUy6ds6UsnQPVODMkUDev2luwba7y
         ZvE9O7UXT8S2tCwpBtwbRKcRVJwJ3N4OXd+LLGeYMFuW2Kno/3nmne6GEUbl3SY/1vTY
         SRWHV1+rDvAtF3n5o6u131Yi+0KBRarWxJllOEqZ+GYt3p816RGgj60QJWtF2qyrpc+q
         i7dg==
X-Forwarded-Encrypted: i=1; AKwUvBxw579SvMEDd5vGir/AWs9sGEUziEQIvL4m1kzT/amW4hJEKI66Ve2U7xUH61F31oDR+u1caBCSfbThJzSgxzfG@vger.kernel.org
X-Gm-Message-State: AFq9FYKD8Si2vXQHC06UgTB/BNjjlcUNArkaM7pLbcLaL37Y0QubGtUL
	jVs1QURpqWYskzFtbzcK6mhqfTQkPOG2u/sp3ExB45iGon4grW4e1iXMCL2vDHJpk4xXKmQP3Yg
	E29qcRfh5zpXf20eRgJ1GTB9zj+rQAAAggYJ4QSdP
X-Gm-Gg: AYBFou1ObPrQycYtx/8cFTa8E8NhPaU181mMjvNJyJcAzG0Y5zqn4tcmDCuJecV0NDo
	/NSuV508Nr7DYdgnfejlvIHmEo6+cvvEaIAjpcopkrBIp5blEv7WWRHtN/dMO9BvJoSlQkxL4TY
	5MvTZTHM0kWNIRy/V9WJZavnH520ZbDVcbSUHu68JQfhZzAVnAyKgoAs9LOdxx/ilx3VHz+oxQl
	qTv5l06cEFpOoX9Cg8ermdE9OcGZ5qhZz59wRUyLPBEHjBZTMeMOcqHwwzNNamMW+dR903v9lFr
	LmpPSA8aDwkaEMpYb1ZBskzWXeZ/pL2ITZNRlzoqbX0D2fDutHE/beJKJGsvJo1S3njfpmY3gzG
	xUvKwDEPKCA==
X-Received: by 2002:a05:622a:6f02:20b0:535:cee9:78ee with SMTP id
 d75a77b69052e-535cee97b65mr42500541cf.15.1791934029392; Tue, 13 Oct 2026
 16:27:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261013182458.1234616-1-irogers@google.com> <20261013222622.1822619-1-irogers@google.com>
 <3f57ddf4-b1a7-4c91-8983-c8cd83d0f25c@acm.org> <CAP-5=fX3e4HRaLXxQhCwEHRuXZdpC0zEEh2pozEEegQBxgc5xw@mail.gmail.com>
 <0e572032-5e5a-4a4f-a362-16ad48f2f02b@acm.org>
In-Reply-To: <0e572032-5e5a-4a4f-a362-16ad48f2f02b@acm.org>
From: Ian Rogers <irogers@google.com>
Date: Tue, 13 Oct 2026 16:26:56 -0700
X-Gm-Features: AclHuK9h2b1Y8G06GgB2ybKX-XOEXTLg3GZrEG0Jt72282bAd9ESSyQw9mVDFQE
Message-ID: <CAP-5=fUmMQgxUqP3tCb694yG7V8PN-Uf_=subMDk+WuAiPJeeQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/10] tools/perf: Adopt kernel compiler-context-analysis.h
 annotations
To: Bart Van Assche <bvanassche@acm.org>
Cc: acme@kernel.org, elver@google.com, namhyung@kernel.org, 
	adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	justinstitt@google.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, ljs@kernel.org, llvm@lists.linux.dev, 
	mingo@redhat.com, morbo@google.com, nathan@kernel.org, 
	ndesaulniers@google.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 13, 2026 at 4:18=E2=80=AFPM Bart Van Assche <bvanassche@acm.org=
> wrote:
>
> On 10/13/26 4:09 PM, Ian Rogers wrote:
> > Which mailing list is objecting to the frequent emails?
> This is a policy that applies to all Linux kernel related mailing
> lists. From Documentation/process/submitting-patches.rst: "Wait for a
> minimum of one week before resubmitting or pinging reviewers - possibly
> longer during busy times like merge windows."

That's a nice try, but you misquoted the documentation. As the cover
letter explaining the fixes makes clear, these are different versions
of the patch series, not resubmissions of the same one.

Thanks,
Ian

> Bart.
>
