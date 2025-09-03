Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BAB92EB853
	for <linux-perf-users@vger.kernel.org>; Wed,  3 Sep 2025 21:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756934598; cv=none; b=LhHqDAMoKOHVnuCuFJNciEhfZ3tosMWoMFf6bLQlA8I7SIUQhzvfsXCZDxvK8sRzplUh3ljd1KEDvREtY/xDyOQ1d7+A1bpxpmuEZP/vXWN/kxd1dpt2PNQyu00iJbIa+aDahnA0YNxec+ebCFH57JpU+vPvCm8pZxsqHUIRUKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756934598; c=relaxed/simple;
	bh=YV5JeLX8eppE8ekya9WYH3l90CIWMh2mNh78A5JQgAk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IDPU8Nv4VLdh1qLVX8JokJ5A1MwFy1Vr3B95yuK8YHUHVT4rGGvMBy9O0u9aVbMWuAVko3vE7gg1uu9CDitBoUd2Lo1eAYeS0am9S+vFl/FdjQ75WdY1UWffE1TJFCLdPVqxJttJn/JLpDl6TQq26Ng+rrQ43CpuXt3JTn+RbTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sPuvS8Ly; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sPuvS8Ly"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-61a8c134533so510206a12.3
        for <linux-perf-users@vger.kernel.org>; Wed, 03 Sep 2025 14:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756934594; x=1757539394; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TTqpzm8Plz8DYgvTTByPTlxjwBnf7eagmEFAvqtbn0I=;
        b=sPuvS8LyYrA+Na5z7Ugx9I+jKuzs6FYxQW9JoTUqt59bO0Y84rzi2POoPXkP2ycM5Y
         zEsHh1Avsbs/dwOKEMb4C2CxFa0IQCrPLH/305V9il45MUcKMjah9+hK2SvoFpKHcabD
         UlLo3xsPSdYWwnx7tzsqNDVSN0pk9ODjnhQT5OegZnUm9AXCqk2QIyDjI5ljR+uDMQw7
         j4OffPED1RwnQVGeBDfaVvskLLdATGF39YUFoCgWXlEgkfLZsmMKNYQ/FYpnNPI1g7nt
         oQgeo+sRMcRGPvIHZPeB1lUQe7hDDYQ6dmNFz2YJV7LakCRtb40kV4qMVOPoidwsGHpl
         4Plg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756934594; x=1757539394;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TTqpzm8Plz8DYgvTTByPTlxjwBnf7eagmEFAvqtbn0I=;
        b=eYHxhwYmAhZkK2t5VQlnWbRHxo1e1wJ1Ao+4aOwI/vqOgy/+C+clDIw1C9T3agR3Vl
         cNgHuaS7RtFZRXfVf6zPe+a5z0MEqIZpX+8A3RcFx5H4cs4Xf+kaeDAYwZbRkqymJ0Zx
         7WBbCFUbK8z0asMeDWYFFyAmDXh1X6jOCBzz60/9+/hvNfasSTYzW2rjDwUtzG4OKBrm
         ikwgVWPpzmCdR1N2ENLcKDhsmXGgzGUsNt6Bhm6y2tW29DZjpv7MHydpbHHTavB42liJ
         aH2tGooq+ASLOwT3EFqdFNAUUXfJ7MfrMb/IRFFmQJ9ZvydaZ40Ma3o2RuviPirFmGtn
         Yj2A==
X-Forwarded-Encrypted: i=1; AJvYcCVaah+Tvqlm1ZAb5Et+xSKZU9/QePEVXDR5YoIjJirAfvwwJn1gpQMkPThpOYRRw9E7w7QMRxanztShWgbe180m@vger.kernel.org
X-Gm-Message-State: AOJu0YxeJ8vfEkrmbHL2gMBfndP/wJYRI46g/USnqhRHwgLVW3YNlJpH
	BJLxeUO+gq7fqIjghsmQidSbYOfRamqKGDte4IxYZt8Xh0jPbVuIuXvKglPgfnL7+eM4Z8qDGTD
	yvYI8f6RZhLPqpD/VPdyaOUxZX3W+s6kpcR3kjVlb
X-Gm-Gg: ASbGncusqlOU8UIDpHspn2qvkmv+wTzBFgfwiB+nHDCMiJIa2t5o+NocSh41V+WKfQg
	RaQE8jrcHWJfocez+oUVl4inhxAoES6xq4xii7Z8oICPUH/CGNmOi8U/JVnycUinTMQjVstvHoA
	EjZ+LmlL+SPnxx3ajKCUJ5WxYjo6rGmVJk244n46ICboYsmayFS/hAUDhbkRg/VQGmBMQwDTblK
	Lb4UDs2UNpt/RWnLwjvjZ4rMZowOm80OOYIR02tdN1FXsF8Z/Tof6Q=
X-Google-Smtp-Source: AGHT+IEXmPGlRSS3y+KTDoly322hxE6u1kV48Yzp4pTSOjFrjS/2qZjmSO36eB/691/J+IRZsHz0s0vjKHuMr9FWmIw=
X-Received: by 2002:a17:907:6ea5:b0:b04:3d7b:ad43 with SMTP id
 a640c23a62f3a-b043d7bb618mr1226009466b.40.1756934594492; Wed, 03 Sep 2025
 14:23:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250825195806.226328-1-zecheng@google.com> <aLKot1esgc3HHubX@google.com>
In-Reply-To: <aLKot1esgc3HHubX@google.com>
From: Zecheng Li <zecheng@google.com>
Date: Wed, 3 Sep 2025 17:23:01 -0400
X-Gm-Features: Ac12FXzobMEN-ZWxzH8JZtzKBn47sB4CsCCDsJiBB-2w7RDo5XQRKxA0s_bfZtk
Message-ID: <CAJUgMy+jTTAQ+=F=ddryLrftyB0h==pezZdvnZAT-UHmSU994w@mail.gmail.com>
Subject: Re: [PATCH v2 08/10] perf dwarf-aux: Skip check_variable for die_find_variable_by_reg
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	"Liang, Kan" <kan.liang@linux.intel.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Xu Liu <xliuprof@google.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 30, 2025 at 3:31=E2=80=AFAM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> > - In match_var_offset, use __die_get_real_type instead of
> >   die_get_real_type to preserve typedefs. Move the (offset =3D=3D 0) br=
anch
>
> Why do you want to preserve typedefs?  I think a variable type can be
> typedef to a pointer then now it won't resolve that target type anymore.

check_variable preserves the typedefs. It would sometimes resolve to
an unnamed struct if we remove the typedefs. Let me test if it will
affect the dwarf_tag(&data->type) =3D=3D DW_TAG_pointer_type check. Also I
found calling dwarf_aggregate_size on typedef'd types gives the
correct result, so maybe we don't need the sized_type in
check_variable?

> > - When comparing types from different scopes, first compare their type
> >   offsets. A larger offset means the field belongs to an outer
> >   (enclosing) struct. This helps resolve cases where a pointer is found
> >   in an inner scope, but a struct containing that pointer exists in an
> >   outer scope. Previously, is_better_type would prefer the pointer type=
,
> >   but the struct type is actually more complete and should be chosen.
>
> Can we improve is_better_type() then?

Here we are comparing two types with the extra access offset
information. In other contexts, the calls to is_better_type compares
two types only, so I think we don't need to add two new parameters to
is_better_type?

> > -                     if (!found || is_better_type(type_die, &mem_die))=
 {
> > +                     if (!found || dloc->type_offset < type_offset ||
> > +                             (dloc->type_offset =3D=3D type_offset &&
> > +                              is_better_type(type_die, &mem_die))) {
> >                               *type_die =3D mem_die;
> >                               dloc->type_offset =3D type_offset;
> >                               found =3D true;

I find changing the is_better_type call to !is_better_type(&mem_die,
type_die) would yield better results: prefer types from outer scope if
the current one is not "better" than the new one.
