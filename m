Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD153EEAC6
	for <linux-perf-users@vger.kernel.org>; Wed, 20 May 2026 15:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779291457; cv=pass; b=GUQPbHjUdrtAWA/SUmXtDJo4zXLdR/2o9VCuxYBFW4SOqIdxNIhAXZ82maW/M3gncipbUH1FksMGTtgWdVAxtgZGs/C6g5W3jEUL1Ojzgsb4OTVJdOwkYlxSD3ln5D23a2MSLNVFtQFLk2VnCpshaAkq5z36TltnqYYBKFtB0VU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779291457; c=relaxed/simple;
	bh=h12W4gqhHecsXKSTpPvVrdNJ58lXyZpHV1wQiR3jS1g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CooiF56p5yaD1uHuXXqoqngQ+cexzY0O5D2PB+DJQEvY6LXgh5w6KHqH07Y0jFy6NnFzR8R9BPfY+qdstWGyaxNSTSo2BBOALc6yIRzF/CLNTroNNzaP8l2nEas6C8MjbAPi7LKFFT+0dfsXncbLtA5+0iW8M2UGiKOkiA5dElM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dtNJDoQh; arc=pass smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dtNJDoQh"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2ba180a022dso8735ad.1
        for <linux-perf-users@vger.kernel.org>; Wed, 20 May 2026 08:37:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779291456; cv=none;
        d=google.com; s=arc-20240605;
        b=RzrC2JiGaKYTjJ6TNTzMf+AWu0ET+5XF3S0MUphP2vim3wDYeZ2P8MFQxcJ6+L2fsZ
         8u3twfmr247jY4HIB9XepBhMQ5Qi0/vsXkWvwy5oevN97GCO1prRgOXirzhTYtC9aOzD
         nBLJNWSDl8t2xzDejnJCaffHFAfXGBPy1/nnXrXewkVQc2CalhluUKY7aFObXh8OQS9y
         MuTpSknwxINTqbL7kS6teuce3P7sHRKoWNnYamwOOdRNBFi4gAnvPVIKnfQYgD+1r//C
         qE2Xz22bTVv2/V1GxmRyyKFyA6pZt2DSaA7pcjJS/3/crw2KfE4UXFyXuHdzGd4z4Gmn
         cURw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UKQdd69TB74alB2+SuQ49zJPbGZZnJPKwOD7M+iVpXI=;
        fh=r6qhtmpknA5Wno2/T7eMWslf7AYcY94j865/aFAx2ZA=;
        b=NEQThXAqAEGUtX8XhAsbQT3Hdp9bA+kky4kCAJrUWMWjQUk2jiALETPlz7/w31JGjq
         dZiz6Um5CRKE/dJD/a+xv/DS7yC2u13q5nGd6kQc3PzJv3DcluYx5H1cZeIgMns16qwb
         /opO1cctZwqILmnUxXc3eff+S9A08oyWD88wybRRXUjRz1Nzdv+UflU8JibhX6ruoe2A
         J0wRklXz+crgL2sjVsjXf02C6XW5R7n3eGwepCdy6XGYXKqHXwRbZjEUAWlnB3RdB9t5
         X+VSd2MNH+yq4bHYzB+3HMFSIvIliVw4qYzt+fIeGKN/lWLHqrMH5TLHSdArlHbIKsQk
         +UUw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779291456; x=1779896256; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UKQdd69TB74alB2+SuQ49zJPbGZZnJPKwOD7M+iVpXI=;
        b=dtNJDoQhJXVSpqk/LhfraCpZkFTKKD3KKIxPIKC2E6SGCzSMTd7/pB6k/WKgphQYID
         cQrWu1OgUv3RmS/pbqeErwJZ4yJUK8uwuD3YCU1JrGt/TAdzV4kIsw8DGTw6zyIODZDU
         zlT2VRIR28jkW749u+jGUb9AT4E1Qwzo3z2uxs240EyaarJkZZQsk3uLpJrNZ+/n29l6
         Zx7sOHlMkSesOuQ7Ea5qKB8onb2hV5OfhYKOfxxLJ+S7vx56whProPtL7qzbXvW9TIWj
         n48zHvVpMkYjKfOaGbKj5Ygz9ETqEbDxJwh1JRVnDAe2X0qe6vqjqg73YP2V94pqJm6S
         thXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779291456; x=1779896256;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UKQdd69TB74alB2+SuQ49zJPbGZZnJPKwOD7M+iVpXI=;
        b=dY0X5TtaL8V6ZO5F9GWbBp9E4xhs4mA1GMrD/IV5+nrXTxNNwQFZ/Ap10cdhvRsL8b
         S4Dt5HEZYENETe7JsPjLaUHLjokzNChUZ35FshSM44CWy4AyLkZn93quEiMcvrh2KtU0
         R1MtjlS6Cp+Ze7LhmXPxF23koE9cAtxXwu7ZAQtIMDHjeCRfYEiniVYdlif7bdtC14Um
         k6XVJ6Vu/x3hW/vWhyxYH6NcdYOxFeoUX9MwZtyvD4ENw7YwGakKZuk17OqJ9+hweBKM
         IKmYYb6KgfsfT4OTraKUZ6cuGJ7PV2ww5LL/qW+MF8d91Hqf4XP+QzL/FCbZlB1NPdgo
         r3Ig==
X-Forwarded-Encrypted: i=1; AFNElJ8yGhj0iuh5yQ+agGNIuvLruJA3mccM5t0fZ4eKcMLu+nU33JAqUdsmO6Q0s6879AZB35fgaMn+B4t0n2zmRGee@vger.kernel.org
X-Gm-Message-State: AOJu0YyuE+Nw+xauuCxSM2aJ/ltGq/fShygOoPvmuij3oGCvU3xk9lqR
	aaTV6hKaUyceXAyMm7SUyR6/QV5DrEIz4ZKaTA+UnBh5PscRKN/k8URgDggnuNdP91X6lS5mWY4
	m7T7koMxicmjAx6ZJud8K8FnGIrJDSgb4jTQZ0Kci
X-Gm-Gg: Acq92OGiyBuzsZGkkO1sjAmnZvTNdyLyaHZJHMLGmbfOgneGC+4ARkby2DWXj8RYetw
	n6GuU/ne9n6rfRcUcBR7tXrRbbnAkaIQ022oGoMQ2DEbJDw3Jfrssp9AM0RUXw3wPeR5O7hWzLx
	FZJpCnWzmws/UCjDB/SRWzSlCGzx6/BFcnO2gvapo9ve71ihw7V1IOCQrsawAeTU4BZDfTrL2Q7
	m7khx65Rv2/nwwXDlstFQIDtpm26T79+IP5JZDLsQ61E5IBcm6RQTRKNwwFxZnOSuN3vvAgzscS
	nosnsCr1QKWLkzEbYWNRQ7breDUUVHQCJaA47mIssKPWltwd
X-Received: by 2002:a17:902:cf42:b0:2ae:6755:a24f with SMTP id
 d9443c01a7336-2bdb0113ddcmr9852975ad.0.1779291455320; Wed, 20 May 2026
 08:37:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260407165551.3075684-1-irogers@google.com> <20260428065432.1877423-1-irogers@google.com>
In-Reply-To: <20260428065432.1877423-1-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 20 May 2026 08:37:24 -0700
X-Gm-Features: AVHnY4L54tzzk7AaFRDYZ8jay5rkttkNPmlBp-47ET5126uZtNEwc8bgMFqOrgA
Message-ID: <CAP-5=fU9m_kHV+qKogUQhZhtguhCoxKsC051APsyQW5zjzbZFQ@mail.gmail.com>
Subject: Re: [PATCH v2] perf clang-format: Add a perf clang-format that
 overrides some kernel behaviors
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: akpm@linux-foundation.org, joe@perches.com, justinstitt@google.com, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, morbo@google.com, 
	nathan@kernel.org, nick.desaulniers+lkml@gmail.com, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 27, 2026 at 11:54=E2=80=AFPM Ian Rogers <irogers@google.com> wr=
ote:
>
> In particular, header file ordering is an issue in the tools/perf
> directory given the larger number of depended upon libraries.
>
> The order of header file includes was proposed in:
> https://lore.kernel.org/linux-perf-users/CAP-5=3DfUitzKwJONTngiW17XkS7kVr=
2cDS4cDL_HccJKcnR2EgQ@mail.gmail.com/
>
> Sorting headers is desirable to avoid issues like duplicate includes.
>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
> v2: Move the .clang-format file under tools/perf rather than tools/.

This change helps format header files in tools/perf, otherwise
following the parent linux clang-format options. Could we land this in
perf-tools-next?

Thanks,
Ian

> ---
>  tools/perf/.clang-format | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>  create mode 100644 tools/perf/.clang-format
>
> diff --git a/tools/perf/.clang-format b/tools/perf/.clang-format
> new file mode 100644
> index 000000000000..902b2f7456f6
> --- /dev/null
> +++ b/tools/perf/.clang-format
> @@ -0,0 +1,20 @@
> +BasedOnStyle: InheritParentConfig
> +SortIncludes: true
> +IncludeBlocks: Regroup
> +IncludeCategories:
> +  # Implicitly the corresponding header for the C file has Priority 0
> +  # C Standard Library Headers
> +  - Regex:           '^<(assert|complex|ctype|errno|fenv|float|inttypes|=
iso646|limits|locale|math|setjmp|signal|stdalign|stdarg|stdatomic|stdbool|s=
tddef|stdint|stdio|stdlib|stdnoreturn|string|tgmath|threads|time|uchar|wcha=
r|wctype)\.h>'
> +    Priority:        1
> +  # OS/System-Specific Headers (directories)
> +  - Regex:           '^<(sys|linux|asm|arpa|net|netinet|x86_64|machine)/=
.*>'
> +    Priority:        2
> +  # OS/System-Specific Headers (POSIX/System flat headers)
> +  - Regex:           '^<(unistd|pthread|fcntl|dirent|dlfcn|poll|sched|se=
maphore|spawn|syslog|termios|pwd|grp|netdb|sysexits|err|paths|pty|utmp|reso=
lv|ifaddrs|elf|libelf|gelf)\.h>'
> +    Priority:        2
> +  # Third-Party Library Headers
> +  - Regex:           '^<.*>'
> +    Priority:        3
> +  # Your Project's Other Headers
> +  - Regex:           '^".*"'
> +    Priority:        4
> --
> 2.54.0.545.g6539524ca2-goog
>
