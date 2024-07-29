Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4B38479
	for <linux-perf-users@vger.kernel.org>; Mon, 29 Jul 2024 19:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722282398; cv=none; b=lnKXlTRPIXQWnc6sJkWZrjwlLJ7IvmRWKolN114CbkRU7zkJQlAWEuXUmmPM5JHFZGrs06nmJiVKDKG2RSjIKnB1GJEdO2gAOdEON43XC7D+MUgHNRzE1Gzz0EfRGcEeZ+5rmmMXbCJXemK+g67QP5Walya0NIHc4dcHmASwlH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722282398; c=relaxed/simple;
	bh=FR/x2IiQiKwgWe94ryrQfqytEtpInOGLjD8sTqSrMEo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MBwP6ntuVkbOUNaxSOIyhSH8KsVHJCMrfkSRQuY0m+sfdojJzwcYPYhPtojIjbKhwxMX1zCzsoTZZ2EFgGXaDyf4E8JydQjuesPfu3B6oH6taHD6ba/1YRMPexSqB6zNkiVihhJIkvtZzoxbBDzcoHR8ToocngzOXVUuxJz//CE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=s2l733R6; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="s2l733R6"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-70d357040dbso2801327b3a.1
        for <linux-perf-users@vger.kernel.org>; Mon, 29 Jul 2024 12:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1722282395; x=1722887195; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Eb6u1v+rp+L34/fq+ePdWX4sBR+FCrH0jIJkH5yVcjY=;
        b=s2l733R6qWbw3INNvzlgjBMnhj5F6w1vFVhl0MZJu1sq0XlL7bi+PXUanH1DbuKNKo
         3wYfXBw7DDJBBwn1/LDIv9YdmAmqgUa842XXeuTlZ0Glfb9Xr+j5t4sIMGkaML+0tpjE
         ZsWf3RFOI4GUgtswmX2FbBPz46rhA10pfNr84SdSfj/2YxcIn69/MigfjmHbBvWy92fq
         sADQ9s9JLspqttPl6UQggWDLLw8LZjhTIiKMdMHhghQNjyGPXzuR/ELwZ7gWBQFMsAdV
         DnAGOHcyJSeBI+reVuBpGO6Y6QUYUtHoDcbwoLyNk/QbXH/mTlMNwv3UsKSzE1c49y2J
         AS0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722282395; x=1722887195;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Eb6u1v+rp+L34/fq+ePdWX4sBR+FCrH0jIJkH5yVcjY=;
        b=LTSJpiZ5OB2GFO0fKJpQAbrkH9+THt8rlWM+1ol1aJ+e7r8QwgmVP1WOt4SmDytjWp
         Cd5Lqs9VhLJxZFClmkkpgkXL34eDQ6OHv1ez4Lrn7Ngk0B7ldCLX3iTX5LzcE6GL0Kr8
         k0V/WIo95v3OPdcO5SGpTMbuSP/dfHX6TAdskVWYYAh4zNPxjiUs88wQw5CG49+N3pXU
         8isIhf5p9cSJuNZYIx7TJ2eYiyDjtlJjO+9wEMv+f+Kl38uD5g9MscXBIxqle2lnEKwJ
         vsTryis06WZWlDyX0KXxGA/NbhHtNP/wOV8ThUII6ay/E2H6H7EFNKBi45XvM43ylJPi
         HYfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVSQqwp5UPryunseU18Suh9PJdiy5TlRFqTzMQGDMcxxXJPfGkNQIpOqhU14xQ2oYk9zsZUtSzvH4eOdEcZXtCJbd7ydthURFmpVivZZMcgKw==
X-Gm-Message-State: AOJu0YzzZ3L+ZiYib2f8W83OEXE+Z3b2TnSwAe9nd2uLohfD4MKyCh5U
	+gakpCgukRj9ZGJVhFmmNUvlqLFGJwBywZ1AToe4kqmky/f0Cd6AMLMSvEf0vXo=
X-Google-Smtp-Source: AGHT+IF2xMDcCMLViVzTPYLxX6qawEepMk2EQYJGWmKToargwVSNSokPyBL0gjsTSIrYtJNenIhKYw==
X-Received: by 2002:a05:6a20:430f:b0:1c0:f675:ed08 with SMTP id adf61e73a8af0-1c4a129a73bmr8141673637.6.1722282395112;
        Mon, 29 Jul 2024 12:46:35 -0700 (PDT)
Received: from ghost ([50.145.13.30])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70ead712f25sm7141309b3a.81.2024.07.29.12.46.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 12:46:34 -0700 (PDT)
Date: Mon, 29 Jul 2024 12:46:31 -0700
From: Charlie Jenkins <charlie@rivosinc.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v2 2/8] libbpf: Move opts code into dedicated header
Message-ID: <Zqfxl82VCxUUi3R+@ghost>
References: <20240726-overflow_check_libperf-v2-0-7d154dcf6bea@rivosinc.com>
 <20240726-overflow_check_libperf-v2-2-7d154dcf6bea@rivosinc.com>
 <CAEf4BzZ8MGa8Ywp_9ztJh6naywqtfrbeGWs4=izw-e-p4GGxcA@mail.gmail.com>
 <ZqfXd0FKtXCJ5dwH@ghost>
 <CAEf4BzZ9B=CPuti9smOqDKD1dRvs3Ug7h9pHupr6jFeKEppJ4g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzZ9B=CPuti9smOqDKD1dRvs3Ug7h9pHupr6jFeKEppJ4g@mail.gmail.com>

On Mon, Jul 29, 2024 at 11:59:47AM -0700, Andrii Nakryiko wrote:
> On Mon, Jul 29, 2024 at 10:55 AM Charlie Jenkins <charlie@rivosinc.com> wrote:
> >
> > On Mon, Jul 29, 2024 at 10:01:05AM -0700, Andrii Nakryiko wrote:
> > > On Mon, Jul 29, 2024 at 9:46 AM Charlie Jenkins <charlie@rivosinc.com> wrote:
> > > >
> > > > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> > > > ---
> > > >  tools/include/tools/opts.h      | 68 +++++++++++++++++++++++++++++++++++++++++
> > > >  tools/lib/bpf/bpf.c             |  1 +
> > > >  tools/lib/bpf/btf.c             |  1 +
> > > >  tools/lib/bpf/btf_dump.c        |  1 +
> > > >  tools/lib/bpf/libbpf.c          |  3 +-
> > > >  tools/lib/bpf/libbpf_internal.h | 48 -----------------------------
> > > >  tools/lib/bpf/linker.c          |  1 +
> > > >  tools/lib/bpf/netlink.c         |  1 +
> > > >  tools/lib/bpf/ringbuf.c         |  1 +
> > > >  9 files changed, 76 insertions(+), 49 deletions(-)
> > > >
> > >
> > > Nope, sorry, I don't think I want to do this for libbpf. This will
> > > just make Github synchronization trickier, and I don't really see a
> > > point.
> > >
> > > I'm totally fine with libperf making a copy of these helpers, though
> > > (this is not complicated or tricky code). I also don't think it will
> > > change much, so there is little risk of any sort of divergence.
> >
> > I did this because there were two comments on the previous version of
> > this patch that asked to change the functions that were copied over.  I
> > had a couple of choices, have the implementations diverge, not change
> > the implementation in perf to keep it the same as bpf, update both perf
> > and bpf, or share the implementations. I figured the last option was the
> > best to avoid immediate divergence. However, both of the comments can be
> > safely ignored, and also perhaps divergence doesn't matter.
> >
> 
> I mean, feel free to diverge. First and foremost the code has to make
> sense to specific library and specific use case. If libperf has some
> extra things that it needs to enforce or check, by all means. I just
> want to avoid unnecessary code sharing, given the code isn't tricky or
> complicated, but will complicate libbpf's sync story to Github (libbpf
> kind of lives in two places, kernel repo and Github repo).

Alright, I like to avoid copy-pasting code but if that's what is
required I will do that.

> 
> > - Charlie
> >
> > >
> > > [...]
