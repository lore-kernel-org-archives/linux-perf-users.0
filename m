Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05602D7393
	for <linux-perf-users@vger.kernel.org>; Fri, 31 Oct 2025 05:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761888503; cv=none; b=qANrgthv3lTChQMtn758VAtdVOHTSbjO5u5bDdym9+WK8P4Ce/y/SKGpDHuuTHCBR8TruAQ+a9eLt2bbpsMe9WsvDkX+iqVsTxb4bIi5gWguwzlwAzT2z0Awp5O2Sts7WtKpo3o3EOKft+BPMUWoueQ4dpw8amK+K+IKpJq3Qhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761888503; c=relaxed/simple;
	bh=pqE9Rb4ICM67LXGEhPtxtgsqOngcvbeqlTIxwrpVoxk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UQ/elX3AN6+D77wtJt1kcM0agg2mTKbRtSyMH2XJ6HcgypN08ibpMgvKAcBOUaiAUM2aK5cJ5LpxB7I78ZpHV/AL92G+jAjtj1Bj3DysPOSfzUIqcPK4M17bvgOmkodCWn1VZ+HEJyIPFSD1+aLT44cZ4Q1AnbcZ2DgSjQ9Xsig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sourceware.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sourceware.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-5d5f8e95d5eso1211763137.1
        for <linux-perf-users@vger.kernel.org>; Thu, 30 Oct 2025 22:28:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761888500; x=1762493300;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pqE9Rb4ICM67LXGEhPtxtgsqOngcvbeqlTIxwrpVoxk=;
        b=D6evtqF5WeAMB6AADuIgM81iWiuxB+4Rt18p4LyW9I4ZH6op5ftalkIPpgpGmWQ2lN
         2CbSdD0PJZdSkgShWDtJ3u33UTCyOd+WvUJ+8aOGka4bQ7IpKTB8CtQBetySQtBU2ehq
         0D79mv971hNiiAcqJQkujX9cXhdmaqiuWHJPnY5v2aVC3czLgRLiKfGWeWdEWYrhZhbf
         Ly1qc6tAlh/v5EegFWGOJNbUxJjmVtetKdB1diR2gBxrDYVe0WhVHBXeyPufcFtciCEU
         H05BXuBT8j4cq5/Gaf7tnYP+6qIha3shgBhB7/U5KZmZhblUsmQkk3WcJHajXhvDt2vd
         x27w==
X-Forwarded-Encrypted: i=1; AJvYcCWR27FyAFDohmLpM/xY3Wt6P/feWTW4Fv2kq+qV4zKwgFY9GEd4o0JvHoPeOlHpb4HV9MFm5mPP4vpKQEh7iMU1@vger.kernel.org
X-Gm-Message-State: AOJu0YxMe0ECIyvKGZAu+/RUZigko0fgPzWnjuz8mw7YL5WS7Qqj3Gmn
	arQ3XkoO3jaKf37IWJYWIqoosq8yj7KlrsACX0HBJhSHAhN/JCuBCQO6oeQD5Q==
X-Gm-Gg: ASbGnctiDrkHCwKLQprE7UKfMpXI320L5u9TQ/9bdLgM3Q8H8cBHBRWLX2o2b8JMVld
	DSSWNY8u2H9lrZzEwo8+gYGvJrsIKNEOk+NpTTTwi9lyeHPsxl06B/TVw6+JyfKsi4ELRhZNgM8
	glnNkbaV+OC7pVYH874mq67/ZvVFmH7G6R28VqIFtfDkL2fNTQSPEgMjydfcGVfikaMmeWf55uR
	4vF+bHrcGrVHbM+mNj/VGk9GI7FHL32CK6J7twSwTMnrFE0ebrO4qnv3RpcbxRDMmQqKlfJcVBc
	F16PlwaTtbywG5e0fnuQzewcN2/SNVM5+GlBso6PTAMlPxXVnlYBE7zaBc0cwvY3xeYgJn+lMnf
	OYJMsjT/LT+InbeOqfCTXxJ9qy65iKHbCiHMd/rUqu+DkyvsOzvdo44WbD6cNtTWCwUHtZdKx2U
	c+9AwAfGSfpXKewkT6iw3JKOVkrn8jA2krtXgfDsCT
X-Google-Smtp-Source: AGHT+IHbeGFNqBpGPXS1jmeUTnPfr4Pc+4rw81F4rHlG4qVv3/7swLLWRNjnjsoNPP67M0YLaxJ2iQ==
X-Received: by 2002:a05:6102:951:b0:5db:ae7f:7b0f with SMTP id ada2fe7eead31-5dbb139bb90mr549500137.44.1761888500327;
        Thu, 30 Oct 2025 22:28:20 -0700 (PDT)
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com. [209.85.222.52])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-93512d26931sm306679241.16.2025.10.30.22.28.20
        for <linux-perf-users@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Oct 2025 22:28:20 -0700 (PDT)
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-934ad40c2c2so816782241.3
        for <linux-perf-users@vger.kernel.org>; Thu, 30 Oct 2025 22:28:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWzmbmVxVqMhrRKPPkP6R8bBFaJ0JKHnK3/bn5BNhM8R9hNx7Fb8B/iFt73wIJbzFY3uEsOwdFcFqqh4qE/rVM8@vger.kernel.org
X-Received: by 2002:a05:6122:80aa:b0:557:c97f:f987 with SMTP id
 71dfb90a1353d-5593e5962d9mr775699e0c.15.1761888499850; Thu, 30 Oct 2025
 22:28:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3xd4fqvwflefvsjjoagytoi3y3sf7lxqjremhe2zo5tounihe4@3ftafgryadsr>
 <20251030102626.GR3245006@noisy.programming.kicks-ass.net>
 <CAN30aBF3MofmVTjTZ9KFq9OBM0nA16amP5VFv+VAEJfFkLx0qw@mail.gmail.com> <20251030133323.3a81c02c@gandalf.local.home>
In-Reply-To: <20251030133323.3a81c02c@gandalf.local.home>
From: Fangrui Song <maskray@sourceware.org>
Date: Thu, 30 Oct 2025 22:28:33 -0700
X-Gmail-Original-Message-ID: <CAN30aBHs_i=Vp0XMRBLgHVtLLCsFCHTRXQFDAeoqpmCgqhST0Q@mail.gmail.com>
X-Gm-Features: AWmQ_bkkCBb44J8qydEViwGcv7ZrA-RSfc0m9YrKRUVjSWUbtdYeuweqQzkIKto
Message-ID: <CAN30aBHs_i=Vp0XMRBLgHVtLLCsFCHTRXQFDAeoqpmCgqhST0Q@mail.gmail.com>
Subject: Re: Concerns about SFrame viability for userspace stack walking
To: Steven Rostedt <rostedt@goodmis.org>, Peter Zijlstra <peterz@infradead.org>
Cc: Fangrui Song <maskray@sourceware.org>, linux-toolchains@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2025 at 10:32=E2=80=AFAM Steven Rostedt <rostedt@goodmis.or=
g> wrote:
>
> On Thu, 30 Oct 2025 09:48:50 -0700
> Fangrui Song <maskray@sourceware.org> wrote:
>
> > If SFrame is exclusively a kernel-space feature, it could be
> > implemented entirely within objtool =E2=80=93 similar to how objtool --=
link
> > --orc generates ORC info for vmlinux.o. This approach would eliminate
> > the need for any modifications to assemblers and linkers, while
> > allowing SFrame to evolve in any incompatible way.
>
> I'm not sure what you mean here. Yes, it is implemented in the kernel, bu=
t
> it is reading user space applications to get the sframes from them.
>
> Every running application would need this information for its executable.
> The kernel is dependent on user space having this.
>
> The only thing the kernel is doing is reading the sframe tables associate=
d
> with the running applications to be able to walk their stacks at runtime =
to
> do profiling. As Peter asked, the kernel cares extensively on that walkin=
g
> being simple. If something goes wrong, you compromise the entire machine.
>
> -- Steve

I suspect your concern is primarily with DWARF expressions (the
DW_OP_* opcodes), which are needed for complex, unusual frames.
If the perf subsystem ignores those and focuses only on standard frame
layouts, ensuring safety becomes much more straightforward.

Compact unwinding formats are designed with this principle in
mind=E2=80=94they don't use bytecode CFI instructions or DWARF expressions =
at
all. Instead, they use a binary search table (similar to
.eh_frame_hdr) to locate the frame descriptor, then decode it using a
straightforward nested switch statement based on the compact encoding.

For reference, this is llvm-project/libunwind's implementation for
i386, x86-64, and aarch64:
https://github.com/llvm/llvm-project/blob/main/libunwind/src/CompactUnwinde=
r.hpp
