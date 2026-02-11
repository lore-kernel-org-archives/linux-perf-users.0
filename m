Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D362236922B
	for <linux-perf-users@vger.kernel.org>; Wed, 11 Feb 2026 10:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770806481; cv=pass; b=Tu7BnpweMUwB7LMeBUprZGnD78LluXB7lWoX7IbfZ9Eq7O3lvWidlTBhi5mKXH7VU957O8XSCVeGlW+UulUc62W5BJ2GLqOROgn+F/YQSDYHLB/6Mu3IV0xKDVU0CcvEGeQcuMSkf0OJCK9DchDn59UepKhcch7pgryWkNMp/oQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770806481; c=relaxed/simple;
	bh=ygS/KJIrgTEQGYtzJb6sDuaxRuXu9QCFvwwEJ6ybjPI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OMCxScTGiAJmIy6lNuFOjJv9E8seo0lC9Wny7vuqLALEV6jSt0L1vVu5aNOi+jZfpm87w5zwmJpZ3r9Uiw/oRtdjb+a5Nn2sGOW5GtYI2fBfS6H+sVJu65T7BEq+u4zEdSfZTSFMZ+ivo+L+UWZ1/Jzne8y7cytKEnKTOV1mMhM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=niAB0vv5; arc=pass smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="niAB0vv5"
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-2ba85f77203so215477eec.1
        for <linux-perf-users@vger.kernel.org>; Wed, 11 Feb 2026 02:41:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770806480; cv=none;
        d=google.com; s=arc-20240605;
        b=SxVLll2rUOAjo1Vo55qkUr3y2c7VZQ4LxaLVbqk6IrOnRXXhworSW07LWhG1elNLjN
         ehjlKObu9tbbyTZyZ0JKZ8u5vE6XlU1vpMaPHUf1TfkCKs+HS+PMDFcNClQeCHCUMH65
         c5lRMsIg+q+hIq3AmvJFCykfYufJldXmmLXUmvtBc3leKsqy1db/I3MmKokSxlP+CKVD
         UkSh3yucvoLg5+s/tiNQqShLi9htbKnQ9A6nZG3QlKgoJyBIvev4tpl/vblcA5Dl0TKi
         qFpBDbpG2Nr+au/EkLG8S8fAjWuHm+hEri0lnHlb8cQb9KEVJ/TW1txnHp+9HVs5Rp13
         pK4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bXHp7S/iyLvY9ql3/OnccpMG4H/yun2WlS91VGZ5/Lg=;
        fh=m4rdyaoamtIc7BdF92XW8Q4KMLRkWc6EocAUGTsMMoQ=;
        b=Gv4veJVrDnp0r0arvemm1TvFtM1kq/XZPW11M82OyYGsjWHaV/RoZAFjaosgVx7pC2
         RUJ9qr/WWyn1+MOS71IiAFa9rB5lvxMQaQogBpbrR4a8FQjIejscDZIkVBLWGFL7alap
         /5v9hS9QCp14jDqc5edd5EhLzxbV/ptSq95hWBddoCxOLGe3rXd8VXzOtszAeTjbe6jc
         8q8ZQR6GRk8RSTX6/aITv0ULziGy0MkAal9wAHe4hUgNJkhFDxYcmnDq0BCCl7L5Dhne
         mFzkJfi7t8tZYGb98LKBjgF23xADW0TAPpaVqMwD4GwG4W6YT9pClekGFP2p+aa9b/ox
         x4dQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770806480; x=1771411280; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bXHp7S/iyLvY9ql3/OnccpMG4H/yun2WlS91VGZ5/Lg=;
        b=niAB0vv5fkMVHGGctevdm0M+COomci0y6ApcLBPj+mIzBzFDpOFWkOOOX5Bw3WRhwc
         k2x2JVEBFObuMj6fw9o0LDIrUt2OAMVLYHc/XrI6mYwS2S3/EpSqacL78sshaaPK31gP
         4+sdH8nS2XIsLjxwstJCCO6W/nSR1w7YYpa5XPNn2Zk9SOweALh9HBPyxWXEcbV09e+K
         30cQ14dZJtMea+4TKM9+c1CypjsCumBABwp22pl7/camZcuqejsIZ2l9lS5crMEFk3YF
         R1gWNgg24r54yu9on1ntrTfOOBTf4XIxuhnCnff+hW/8Iqtc0OjlMEzxcfhtFyg5L7XP
         shaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770806480; x=1771411280;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bXHp7S/iyLvY9ql3/OnccpMG4H/yun2WlS91VGZ5/Lg=;
        b=IVqqbf8dImGf55RTjWcp8H66T/73pXv3ptddzp0FlCGlGKCLyG8oQCeZ468VC0Bc04
         e8r6LesFd3VjdopJ799gQy1EEDs25+2vfMqxTE9SETscTe9oTHP67v0bb3DSlu7sK9xC
         DPmS3GwUbMjaaNfZeU7/CZG8xUR6K6Q3Yc4zwtNbKUr7I6pPz2UXMBiIGkoi8a/bs7nO
         ltDe6P6pDTn+g1fdrKdb/Xb78RNBn6resui/SU+w2wZRAj6gnM72dYUZJ1yeu3E6slXy
         XUp+JkwH+byO42gVAIGQ7zS4ExTWn3oCpK2NNiIt8O3qVBWGVAxKWi41sk3HdeCZZ+u0
         hKgw==
X-Gm-Message-State: AOJu0YziIz94jmStH3BMYaM9BadOm4JQUaCipfyCgvuby/FixAatH4VD
	Sgv84M4n03ECdewBk2pJYXr1RpzFs8tfm4z+TaPMf/6uOkGF6S9CS0g+7TqZ5Ae5BTmF02Qa7Ro
	W0Rztc0hTX/H43I3H6YGn/ZxtLQ8PsAM=
X-Gm-Gg: AZuq6aJNqjrxcMc1v00+qewsdQibHMzBQxiOQVEi3vSFJO94SJGiDq/0V7WQewIcKjC
	hKK1vnhgqzIAVYX6ZIwBOybud+e5hKzyRCQXZ3IeOQqB0cqexDAu+zaYr9py8U+nfmr+KsQnLXs
	p1EKXgfjc9HOxlgFAlNAS0D+EudJktdWemrQqiPo900KjnPJKs1qoRei/acae8nKAvU2yvXCuir
	bFwPUgkWDnisFduDNVKCKHqxqBfFntAbbdV1iwTjrihBKap2vq0rfEE3XbSxqXzbbl/DINXIxvV
	IM8ykzYEVrZ6u0mhHDXfz27W7mjSUssrdcpKVsv/Qx01sQJZpA33DIe2lia9qidTuGEdcQGhSUc
	zRaXGKgc03vYilChS3sgXeHv1dp16pBuuAZM=
X-Received: by 2002:a05:693c:40dc:b0:2b7:ff3a:af82 with SMTP id
 5a478bee46e88-2ba9e05a837mr206329eec.1.1770806479793; Wed, 11 Feb 2026
 02:41:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260211095807.132855-1-9erthalion6@gmail.com>
In-Reply-To: <20260211095807.132855-1-9erthalion6@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 11 Feb 2026 11:41:06 +0100
X-Gm-Features: AZwV_Qi8-0s8a064H_jd0KP3XaMxJ_Cg3S2G28D_5OStfj3L5c7hvaHWqbAT4yI
Message-ID: <CANiq72mFBaFm9QVotxeDB0TanKxQRko7ZFhuF-RHq-8WCemCTQ@mail.gmail.com>
Subject: Re: [PATCH v1] tools build: Fix feature test for rust compiler
To: Dmitrii Dolgov <9erthalion6@gmail.com>
Cc: linux-perf-users@vger.kernel.org, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, 
	rust-for-linux <rust-for-linux@vger.kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nsc@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 11, 2026 at 10:58=E2=80=AFAM Dmitrii Dolgov <9erthalion6@gmail.=
com> wrote:
>
> Currently a dummy rust code is compiled to detect if the rust feature
> could be enabled. It turns out that in this case rust emits a dependency
> file without any external references:
>
>     /perf/feature/test-rust.d: test-rust.rs
>
>     /perf/feature/test-rust.bin: test-rust.rs
>
>     test-rust.rs:
>
> This can lead to a situation, when rustc was removed after a successful b=
uild,
> but the build process still thinks it's there and the feature is enabled =
on
> subsequent runs.
>
> Instead simply check the compiler presence to detect the feature, as
> suggested by Arnaldo Carvalho de Melo. This way no actual test-rust.bin
> will be created, meaning the feature check will not be cached and always
> performed. That's exactly what we want, and the overhead of doing this
> every time is minimal.
>
> Tested with multiple rounds of install/remove of the rust package.
>
> Signed-off-by: Dmitrii Dolgov <9erthalion6@gmail.com>

Not sure if Kbuild covers this given it is `tools/`, but just in case
given the `MAINTAINERS` file, Cc'ing them, as well as rust-for-linux
since we try to use it as an index of Rust-related things there within
the kernel.

I hope that helps.

Cheers,
Miguel
