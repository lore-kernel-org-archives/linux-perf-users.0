Received: from mail-lf1-f66.google.com (mail-lf1-f66.google.com [209.85.167.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4492B13DBA0
	for <linux-perf-users@vger.kernel.org>; Tue, 18 Nov 2025 07:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763450942; cv=none; b=F9MJOz3O8h0GCosPUlJcJNgXczZMmyTZHAOv5wLm6NwtcGlqQNqrIMK9GKMwqtP1NH2pjZSzqNfQWudtbtFLhc7h/9QsTTnGjBLF20cgoSqek3nzpLEaBbO5uNDdhhUKnQp/2cSj2Hg+84Q+K2k0GahKEwNAfDAM373Gy684EM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763450942; c=relaxed/simple;
	bh=70toKdk+d/xNXNS5e0pylcSzKrOv1XeMT95DFQkmNag=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F3SZcLPX+EjxwT2xQSGMt8a7wKQhEZwpbot1xFJsVbHXhyse7HjfyfRyPlIMVuurNBnrq22LmnXVnsCCC19MUnbU0YHFZ0V21JT3nm2pyARCVtIc9uW/WYtrATE1OSULjJWP8ugOOfPJ4uemhXLRi0XbOpPD9fTvRHRBpOY7YUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WbuM80s1; arc=none smtp.client-ip=209.85.167.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WbuM80s1"
Received: by mail-lf1-f66.google.com with SMTP id 2adb3069b0e04-59578e38613so5536818e87.2
        for <linux-perf-users@vger.kernel.org>; Mon, 17 Nov 2025 23:29:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763450939; x=1764055739; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FLjJBvcjdxGIbfuF3deEYGVfgeDIoTuMXGx329fUUGg=;
        b=WbuM80s1D+CW6b3hffzF1KIbX3PzxJngVJuUPWroQHDdTNTI9Etw07HFkpNl2wm6e4
         dvI/WeAL6FpkBYyZfRvLAOvJTpGrt84ESQTc92/2LACa28eJljbgMRr0kGkTgFS3SYf4
         BrLfVd3TBc6rRd2K4x4JHK+PGhOHVTxOU9iC6vmYq3P5Q0xiRkuVVZL8ZPGL72MessWx
         8nWdODOzT+4aaqqJvG5gSOZNMj9XrGmeEMkeuS42hLiIZ6784Nlwd4cXkBgiWt+3F8QG
         Fyb7OO0UYn4OgH5ITpGmrZ/HNpjPBEayOctrLogbNUlKaP9QJoYUdxGb+qnAZ+MuYUpG
         c+bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763450939; x=1764055739;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FLjJBvcjdxGIbfuF3deEYGVfgeDIoTuMXGx329fUUGg=;
        b=siNdMzWAhk0XruB2MDO+H04AS18F622Ww+pPBF+PQy6DuObd6CZZ5iXfvkKHX/vIFc
         dwB8t+tO7eLj5ehE34u3HNna0ELjt4OCJ/rhBPiJG6/qRoohGYz3+nQbc7KjH1Ex+rYw
         jSFoatpBthTQC5TCq68uLke1t4kNqIFbKR6vzI/L9F3nG2zBJ4X46whzRuKZtcxTzdoN
         tfp+TyR+NEISEKIrHO1rjIwuDEtnm0RzubG+n1gWmnXxKrqLMO/g0ZNXcQl5CF/RiKIg
         VFet/OV6Rx8Pkkk/cWr7cDOGxaoklA04jPaVslWKrUP1rbNoWTDHeHoTO5/AQGbhR63/
         gCuA==
X-Forwarded-Encrypted: i=1; AJvYcCX2Rt0vLfiZP3y2NRg69SCT6ErYV5kIAulvZLGpnmkwloss9mqEwGzP0VcVvR/0bF1Uf6sjRUVTTsoV9IdzaJMM@vger.kernel.org
X-Gm-Message-State: AOJu0Yzu4GeMBQLV90DSqVCu4TRUoRqfdPPqjmdOhP+x4kJMR+oq2Yk6
	2SMWAtar5Zet0kbFgI5HzHGaMeRxxaXOhdO5/Y4rMkN+OzINLHY0hEmi0yLvWg8j3MQk7VqyzZV
	+W8ge4DPaJAuH6jkT1lVm0CraN0TzIUc=
X-Gm-Gg: ASbGnctwWb9Mk0gC9t1ByMvDZs3zKp8+e3fmKQ0qFUnFhmm6P+9Psv8mnzZV5i5UwhR
	qA7Ws7lY/EyncOBq6iemxeSGSRau0dH+wijxW4+Sc1dCcnav8GpCUSo7mh3nXHr0mQ8YSSUHVjS
	1sP+fYIWWnI/+MBcvVYqKoxbmAcQxR1yTNcTzInXMhFqo3oNq9Kj6/oLMWaupZRiRIFniEhSi9A
	4o9Xv2xQ/7a8WjeSKJhtkVFSUTjK9osgkQ2l37Kf+62D31BnUGxX4oU9jYl
X-Google-Smtp-Source: AGHT+IG6DEMKjBOyARk0+W/Yr7aQhUUGV+aAyrbedCQjNwC1feyiHTDZI0M5wWXWNnPmDUIWuj9E7OrzVlmP7cUgCFA=
X-Received: by 2002:a05:6512:1550:10b0:595:90ee:f46c with SMTP id
 2adb3069b0e04-59590eef56emr1622417e87.9.1763450939127; Mon, 17 Nov 2025
 23:28:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADHxFxQHFkn-J9R6AJY8LxkDN-eTWjp34VvoQDcshfZs1eF0rQ@mail.gmail.com>
 <20251020024049.6877-1-hupu.gm@gmail.com> <aPW3rilb8DtFDIMC@google.com>
 <20251020101523.GE281971@e132581.arm.com> <CADHxFxQjMy9n7G1dUX=HLi3b5VFjMd8YpBP7DOQyOdaQp443mA@mail.gmail.com>
 <CADHxFxTHYwjqAjURTbkZ=6-4Ti0GGc7uKsrjthL9s78rAgv5EA@mail.gmail.com>
 <CADHxFxT9fXfKVDXWxoFs0KeG+gssNhZE3y6TGKGtS=AhKPdGAg@mail.gmail.com> <CADHxFxR2t4jMmjm3hMdhsxoRjUw+k3CtrG6ZzG39b_BhVzyzsQ@mail.gmail.com>
In-Reply-To: <CADHxFxR2t4jMmjm3hMdhsxoRjUw+k3CtrG6ZzG39b_BhVzyzsQ@mail.gmail.com>
From: hupu <hupu.gm@gmail.com>
Date: Tue, 18 Nov 2025 15:28:47 +0800
X-Gm-Features: AWmQ_bnpaW1CjmQjlnuuO40DoPt0fulVUcpqccYk7DiY3VQyUhoIIXW67rggKzs
Message-ID: <CADHxFxROMe++VB17J3UgOxSoEhJ7bNagBHO6gRQQPpAELc1ocw@mail.gmail.com>
Subject: Re: [PATCH] perf build: Support passing extra Clang options via EXTRA_BPF_FLAGS
To: Leo Yan <leo.yan@arm.com>, Namhyung Kim <namhyung@kernel.org>
Cc: acme@kernel.org, adrian.hunter@intel.com, 
	alexander.shishkin@linux.intel.com, irogers@google.com, jolsa@kernel.org, 
	justinstitt@google.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mark.rutland@arm.com, mingo@redhat.com, 
	morbo@google.com, nathan@kernel.org, nick.desaulniers+lkml@gmail.com, 
	peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Leo and Namhyung,

On Tue, Nov 18, 2025 at 3:18=E2=80=AFPM hupu <hupu.gm@gmail.com> wrote:
>
> I then added KHDR_INCLUDES to BPF_INCLUDE, pointing it to the kernel=E2=
=80=99s
> self-contained header directory so that the build prefers headers
> provided by the kernel.
>
>
> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> index 47c906b807ef..65c6e871988b 100644
> --- a/tools/perf/Makefile.perf
> +++ b/tools/perf/Makefile.perf
> @@ -1202,7 +1202,8 @@ endif
>
>  CLANG_OPTIONS =3D -Wall
>  CLANG_SYS_INCLUDES =3D $(call get_sys_includes,$(CLANG),$(CLANG_TARGET_A=
RCH))
> -BPF_INCLUDE :=3D -I$(SKEL_TMP_OUT)/.. -I$(LIBBPF_INCLUDE) $(CLANG_SYS_IN=
CLUDES)
> +KHDR_INCLUDES :=3D $(abspath $(OUTPUT)/../../usr/include)
> +BPF_INCLUDE :=3D -I$(SKEL_TMP_OUT)/.. -I$(LIBBPF_INCLUDE)
> -I$(KHDR_INCLUDES) $(CLANG_SYS_INCLUDES)
>  TOOLS_UAPI_INCLUDE :=3D -I$(srctree)/tools/include/uapi
>
>  ifneq ($(WERROR),0)
>
>
> With this change verified, perf compiles successfully even without
> explicitly specifying the cross-toolchain sysroot in the compile
> command.
>

As an additional suggestion, I=E2=80=99d prefer to keep both the above patc=
h
and the previously discussed PATCH v3, which would mean submitting two
PRs. From my perspective, allowing users to pass custom compilation
options via EXTRA_BPF_FLAGS is more flexible than only configuring
headers, so I=E2=80=99d like to hear your thoughts.

Thanks,
hupu
