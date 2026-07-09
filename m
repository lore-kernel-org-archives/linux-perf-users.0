Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6185C214812
	for <linux-perf-users@vger.kernel.org>; Thu,  9 Jul 2026 01:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783561801; cv=pass; b=Xw2bGBzVuDr0996XEvfcUoyax41f+9wGxMFdLJ+UM2SCjZpabac1t9eqpoD/LiRdGroIYyh0T4tTCx9IgQyUw8eFfiUm1xwaY4mH2Bw6hOEdyf7vj4uarEh0y5R1fFgr1FUka2m5T3JDtGTfte0v41tqLvbNtnPWatUqYFEf/QI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783561801; c=relaxed/simple;
	bh=5X8gEOufajX/k3LMXa53quluxWlweCjVeDS5ZzyxYSQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IHypxyDjUEgcpHjb2uTZFg2/AUlUCv3exAqoNxbhOJbpqcxF9pQ0LvexO3vLa/ntfBdMgfwi4uURWRW/vQLPF5KFwZk6DzaPGA18UWeudmEhrsndJ3F/RdSC2tvo+TbFFA1WjF7dv+Ew936nEm4FjCn7qtB08sYn86N95PJLa/8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mYY3kESp; arc=pass smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mYY3kESp"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2cacef7d299so33875ad.1
        for <linux-perf-users@vger.kernel.org>; Wed, 08 Jul 2026 18:50:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783561800; cv=none;
        d=google.com; s=arc-20260327;
        b=QN46/Ue+28ECIgI/PKD7ucFUTrmPXM4fPBdQmlcwT37nvDrSiocT2E/9+0082Ci6SZ
         STWhDsqXa/nFkFfztgi9u4QaNHpLduIhR0OV+1XNvJbO10ssr0yt1SMKqRbxmcaSM6oN
         PqyRFFV52TrzPw4faCTN4vy2VjieqCupr1VYpqC3A2J/cwM9mlR4M50VIQqV4AX33blw
         Sp2OCl2c06SzxG9TfCcEHXIAfCYw1XrVnM7hgkpaw+itvzts7Jf+YehfErPfHd3keO/n
         GYn2E+56gM2Y+2UmhAFPR4E7414U9RwMVRIPqaQUSCQTd0w5oSMNrxiMleaVA5zzasrP
         nMIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=W17fW+C3mHL0CbDL0yXl4m7DTkzXAKvbJHBtth2Jzsk=;
        fh=pi30lagK+Df0bi+zZbwpLVX+z+HnVuWQRbrDstpfjaM=;
        b=g6nklgF5dOdt8JhxEec3wASVPqxYhCzic74KDZxRFZt4M26ugBJzKrdcjZFbIjuPRq
         723OiunzJC2CmCuRkPr9SFBPaG3IEsFwpwPkW2eL+pR/j1TGD44uKT/A+Y6NKPAiFYgs
         Ob9UyTK1rX+7xgI9D6XD6xcWnIVK+t0f1P3xsxm4SodsFJ3hvJmArfSpD8KhXkOuDEvm
         462vNSWcYvcei+e1djBFkWVexXXxKPC/eUajfn/12V0MHjTO6Dc4xS1sWGxztGoYBt1H
         9sreTGgZs9zNadMw8Cr702QR7mLNbAMwO2xOnXJ9F5VjubQzvDR7j9yR1eC/GvQloUir
         cavQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783561800; x=1784166600; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=W17fW+C3mHL0CbDL0yXl4m7DTkzXAKvbJHBtth2Jzsk=;
        b=mYY3kESple3DbxcPy0JpLmBfmzQEt7uPEFYFKsVti4iQJcgUpnLhJYXLguBGx0FMe/
         2W4dXvlb+py3/EHoE+PIL0ri0TWz2sU0Uq7cjfFDRI6OGDhBvu1WHfBP3sZLSQUd7Yxu
         R443pVhHRxDYVhh99AsN8AImVpv8oh9/RCXWr+yJU8m1Ve5nI5xE7QheQpJQBkF5sSBP
         WOwo3JIZXomsxr6RfZkanBdU3UfltvYJKojgy5ZRc4fwVVof8leV8hlwFkv2gO9xizWr
         v+UcfNXAcUSJQ9i5Kl+jtJHOrTRdgTAv8fvqzZN1JtSFvUSG86l0lOlUkMkT4yPlizBi
         rwPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783561800; x=1784166600;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=W17fW+C3mHL0CbDL0yXl4m7DTkzXAKvbJHBtth2Jzsk=;
        b=SI74e4ilctj9xcpEQe0bmPkeMm/RU6+kfxjtNOalXy7hHbSswYBnS3UA9LLdX3iSN1
         phkpYv4JEf/vpGjhCtbaWpdQ7XhX8s8i9p3S12UixIePitr02g6lKI+s3k1DkYWm4VOG
         ycOZpfXwzyDVD95KjUrrT/zh+27diFcsPHzEpJt7vvZxN+QBhcNDv5Lw3zDBAuEz6NhZ
         rKHKSckjMN9Hz/m5CfVZIRvYTDul2vzJ13/jVT1ofjlTLaEwErAvV4rH+az5gi743Rh6
         tstCORejyY2JWN9e3bkB4K0y8sdqMZya8MG/GViO7y5QOaEcMTi1EyAxWXFu2I5NN2m5
         9U0g==
X-Forwarded-Encrypted: i=1; AHgh+RoI5ZcbYAF756Dig5Jxo8/8J5fFR1flgeaZxxad0IxLfV+kN8/CXJFllwoa3ADvHYPil0f81NcVq1NPuLsBpGSg@vger.kernel.org
X-Gm-Message-State: AOJu0YwKaS795xnUaeQo4zftNmcWGRiL3nOjodhYhfQh3GysBnBhHHO3
	NaaCmNST1oJwgg34UWVOR7pURFM81Ty4E3dNLGs7iZ1CeMcLWb2fz0qGX7NjMpeYZmjU27VUODO
	UjIWcT7dJqG7utZIACDwoppJfJt5omhSwlskqXR3z
X-Gm-Gg: AfdE7ck+QN4JKcBBG+yWaEcuNjB5xHi0kGfDVYcC+wH1ImD4IgGCyFZmTSgie5KVUNj
	hSXVR2KkygMxpkSPHnPiQOWHaLqiNWqjQMwL9zboiisXsZmHRtI3ZE9VC8BmPGlQiT/yXcN9NQW
	/fXTyAJUwNtiUpIA5MeCKwuRz4fPgjOnJpaHOi52Z5F4kF/FLsgqwTmB3MV7Kj3VnsDkwv3d1g9
	OmaKpggQVWZAEIOpHQNwXewoTmfL+6T4MvYJgKUYCLQvX+7f+ehGFfr+uUe6GfFGwaIIp+814VS
	85QY4W1l
X-Received: by 2002:a17:902:e948:b0:2bd:6dad:7ccd with SMTP id
 d9443c01a7336-2ce6661353amr429915ad.25.1783561799151; Wed, 08 Jul 2026
 18:49:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260701042145.71595-1-tallison@redhat.com> <ak7neuxFS3ZuGL4F@google.com>
In-Reply-To: <ak7neuxFS3ZuGL4F@google.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 8 Jul 2026 18:49:48 -0700
X-Gm-Features: AVVi8Cc30BTZyhJ-0yZ7XQhtGONH8wJpA8ctzU82Na7W-0VShUU66nsIlDrnnxo
Message-ID: <CAP-5=fV7Ei0gBneNvBb87a8pWbjrxpCy-rVrLACbk7OBLXR+OQ@mail.gmail.com>
Subject: Re: [PATCH] perf build: Fix LTO build of libperf-jvmti.so
To: Namhyung Kim <namhyung@kernel.org>
Cc: Trevor Allison <tallison@redhat.com>, peterz@infradead.org, mingo@redhat.com, 
	acme@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, adrian.hunter@intel.com, james.clark@linaro.org, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 8, 2026 at 5:12=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> Hello,
>
> On Wed, Jul 01, 2026 at 12:21:45AM -0400, Trevor Allison wrote:
> > Linking libperf-jvmti.so through jvmti-in.o (ld -r) breaks LTO when
> > -flto is passed via LDFLAGS.  Link the JVMTI object files directly
> > instead, and pass any LTO flags from LDFLAGS to the JVMTI compile step
>
> Can you share the error message and put it in the commit message?
>
> I think my build is fine with LDFLAGS=3D-flto.

I had to do many manual steps to make LTO work in the past (IIRC,
using clang and lld). We do have an LTO option in the Makefiles:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/Makefile.config?h=3Dperf-tools-next#n266

If LTO is ready, maybe we can add it to the build tests:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/tests/make?h=3Dperf-tools-next

Thanks,
Ian

> Thanks,
> Namhyung
>
> >
> > Signed-off-by: Trevor Allison <tallison@redhat.com>
> > ---
> >  tools/perf/Makefile.perf | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> > index 3f0544d37a7f..bc66d711fa39 100644
> > --- a/tools/perf/Makefile.perf
> > +++ b/tools/perf/Makefile.perf
> > @@ -686,10 +686,12 @@ ifndef NO_JVMTI
> >  LIBJVMTI_IN :=3D $(OUTPUT)jvmti/jvmti-in.o
> >
> >  $(LIBJVMTI_IN): prepare FORCE
> > -     $(Q)$(MAKE) -f $(srctree)/tools/build/Makefile.build dir=3Djvmti =
obj=3Djvmti
> > +     $(Q)$(MAKE) -f $(srctree)/tools/build/Makefile.build dir=3Djvmti =
obj=3Djvmti \
> > +             CFLAGS=3D"$(CFLAGS) $(filter -flto% -ffat-lto-objects,$(L=
DFLAGS))"
> >
> >  $(OUTPUT)$(LIBJVMTI): $(LIBJVMTI_IN)
> > -     $(QUIET_LINK)$(CC) $(LDFLAGS) -shared -Wl,-soname -Wl,$(LIBJVMTI)=
 -o $@ $<
> > +     $(QUIET_LINK)$(CC) $(LDFLAGS) -shared -Wl,-soname -Wl,$(LIBJVMTI)=
 -o $@ \
> > +             $(addprefix $(OUTPUT)jvmti/,libjvmti.o jvmti_agent.o libs=
tring.o libctype.o)
> >  endif
> >
> >  $(patsubst perf-%,%.o,$(PROGRAMS)): $(wildcard */*.h)
> > --
> > 2.50.1 (Apple Git-155)
> >
