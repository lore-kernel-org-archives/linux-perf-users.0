Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0BA6204099
	for <linux-perf-users@vger.kernel.org>; Fri, 14 Mar 2025 20:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741984456; cv=none; b=IRC/9qiZHJ874gEPRbwMHMQ9LaAFC88tXvAeFkzLw3Rlm4KYizDWKHPjwd2hCk+jQ9NTSOgaR4sDVo19OiCmkQLDNCBGE60F0xpnA0A0z6YdnzYFFJkRPv/zdi/kSaGGEvX9uSH7QWOqQ/7E4JzFDgMWqA6Dd/ZbAeUGXcW3hlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741984456; c=relaxed/simple;
	bh=c4wwXFuyd+09V8nYlFwZSaI4yQEVtJ2TGuKQbNyPRfA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EqnLarVcw09EEHlwoDxlnqxZEu+l6HZ9B5+KrwOz5QnyyMX0NVzRjiUZIcN9MmB0Ckok9UdKhckDs0upTWRav/KeCoJN4FTCQYPdxI0NFRp38yZiUq44twRSZR3wqBvljxtPtFgw8zhNM35PTaUEldKgtuIxinpRVbMIfWWZi8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BiYyAKxa; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BiYyAKxa"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2242ac37caeso39895ad.1
        for <linux-perf-users@vger.kernel.org>; Fri, 14 Mar 2025 13:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741984452; x=1742589252; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a9Yo0jce7GsP33A0Q9dWejB0soHGZhgKYNgRPCzK2O8=;
        b=BiYyAKxaP6RgUoWVRpwm0ikmve5UwQevwQmc1fMNO/KW17GgsN1e/7j2jgp1CYLdjg
         HcLbxlvtIRrLoNvq3BBgix8G1YclkE6vWKDZIuVi649eGgeSj8EkvclSKATSgL400q1a
         9DIWjusN97sajLYokL+fi6fgua78fnDdgOhS3iXKcb51l3n3uI9OwPkf63OktbPmnEM9
         4FQnyJVK97XzQoNR6Qg/MIzYU1RnX6OnjFr4nshks3+cDT2qH9UrX4oE92uxSuzmxmnu
         F2EetlS2XwBdjAOxARhk7PYirQcVPo/7UXoDwj47dsk72p2IkQCKbESLjQFHpcDjuasj
         Z8ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741984452; x=1742589252;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a9Yo0jce7GsP33A0Q9dWejB0soHGZhgKYNgRPCzK2O8=;
        b=FTH7nkSpFz9emPANDV6sRbIIwwiITKt9AFCtfkqzYwUzmpF3V5HgrzUmaV539XJFS0
         debs1MSIB6Sg1eZ28WOceeymntDRnwl3IEDEMxKy+GcDE7lAK4YCk3pDblXe3qVwR9iZ
         2p8D4y9/nt0OFTgQK6tCarg3vDiWs/Au8kDJg818YdoR/AOsxGfvoMtMi/qhX0em5gyO
         zEKX8Eix+KmshuDvFaAMh1Lwi8ZOPSPK42wPwAXp3uswAtQ1BeuGxs9Wfq/ww/3W16QT
         5wzpf/OJ4TRD0jNTP4vu5oiJ4NnTw8m45IGesZxPIDJsCEkgwDEdbxUwAHcTJ6yKopbb
         jjRg==
X-Forwarded-Encrypted: i=1; AJvYcCWl2SMMplIIvys5E33v+utYb7lFLJjAIjdf6169P/BXS5tKbUkge/648kgWvuieuLzKgEPSOkvrVmrAPHnFa+HO@vger.kernel.org
X-Gm-Message-State: AOJu0YyDV6aYV1DE5p1YRMs+v3rgDJCjwpKdk8GGuViBj9RzJ5F9gCUl
	JwHuDueZ1ffS9blmK6UuhuEoy1D2c93maZCIoz1GC9oUoEf5FQurSDVJOekU8DVOV1rGKPg6wBy
	wvJwbCiDc5LpwXm4iScUEq0Tk10oUsUKzVVpB
X-Gm-Gg: ASbGnctWZqNiJvTyPe8URhwTsNzfqkNzpthlU+TZRdZsBNNvBWKInFVsAbjvYb9bkxG
	6qNvhOQIJVLIVPzatJ/Bn/a5sxfQMVWqXV1yPOxfIzemrh2A+/9VUDPvcRvh02bEp+84XGQ2d6M
	qi6FjfH+xdqJEd0faW3ZYaMarHK/8rbLPXfn5yRFHPfbLo8bdN9XNY0Xs=
X-Google-Smtp-Source: AGHT+IH8lndJdL7NKJPYr5hvLG6zZyAsU+28Sd0KOcd1NkXO/cXOf7zDj6pw0lueMe4InFY+SymZ15Oxm8ynkeetjBg=
X-Received: by 2002:a17:903:2f82:b0:21f:3c4a:136f with SMTP id
 d9443c01a7336-225f3eb05e9mr547905ad.28.1741984451984; Fri, 14 Mar 2025
 13:34:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250122062332.577009-1-irogers@google.com> <Z5K712McgLXkN6aR@google.com>
 <CAP-5=fX2n4nCTcSXY9+jU--X010hS9Q-chBWcwEyDzEV05D=FQ@mail.gmail.com>
 <CAP-5=fUHLP-vtktodVuvMEbOd+TfQPPndkajT=WNf3Mc4VEZaA@mail.gmail.com>
 <CAP-5=fV_z+Ev=wDt+QDwx8GTNXNQH30H5KXzaUXQBOG1Mb8hJg@mail.gmail.com>
 <Z9NbFqaDQMjvYxcc@google.com> <Z9RiI9yjpMUPRYZe@x1>
In-Reply-To: <Z9RiI9yjpMUPRYZe@x1>
From: Ian Rogers <irogers@google.com>
Date: Fri, 14 Mar 2025 13:34:00 -0700
X-Gm-Features: AQ5f1Jp2oSwzsxV6loOKp3swePrskzYf2sJiobz94hX3O8DCQYyq7eJZBKLjY0k
Message-ID: <CAP-5=fVGV=dbidHic4ae6EHV4cLF2M11wD17LsWntvhq_fcVTw@mail.gmail.com>
Subject: Re: [PATCH v2 00/17] Support dynamic opening of capstone/llvm remove BUILD_NONDISTRO
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Aditya Gupta <adityag@linux.ibm.com>, "Steinar H. Gunderson" <sesse@google.com>, 
	Charlie Jenkins <charlie@rivosinc.com>, Changbin Du <changbin.du@huawei.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, James Clark <james.clark@linaro.org>, 
	Kajol Jain <kjain@linux.ibm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Li Huafei <lihuafei1@huawei.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Andi Kleen <ak@linux.intel.com>, Chaitanya S Prakash <chaitanyas.prakash@arm.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	llvm@lists.linux.dev, Song Liu <song@kernel.org>, bpf@vger.kernel.org, 
	Daniel Xu <dxu@dxuuu.xyz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 14, 2025 at 10:06=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Thu, Mar 13, 2025 at 03:24:22PM -0700, Namhyung Kim wrote:
> > I think #ifdef placements is not a big deal, but I still don't want to
> > pull libcapstone details into the perf tree.
>
> > For LLVM, I think you should to build llvm-c-helpers anyway which means
> > you still need LLVM headers and don't need to redefine the structures.
>
> > Can we do the same for capstone?  I think it's best to use capstone
> > headers directly and add a build option to use dlopen().
>
> My two cents: if one wants to support some library, then have its devel
> packages available at build time.
>
> Then, perf nowadays has lots of dependencies, we need to rein on that,
> making the good to have but not always used things to be dlopen'ed.
>
> Like we did with gtk (that at this point I think is really deprecated,
> BTW).
>
> gdb has prior art in this area that we could use, it is not even a TUI
> but it asks if debuginfo should be used and if so it goes on on
> potentially lenghty updates of the local buildid cache they keep (which
> is not the one we use, it should be).
>
> And in the recent discussion with Dmitry Vyukov the possibility doing a
> question to the user about a default behaviour to be set and then using
> .perfconfig not to bother anymore the user about things is part of
> helping the user to deal with the myriad possibilites perf offers.
>
> gdb could use that as well, why ask at every session if debuginfod
> should be used? Annoying.
>
> I think perf should try to use what is available, both at build and at
> run time, and it shouldn't change the way it output things, but should
> warn the user about recent developments, things we over time figured out
> are problematic and thus a new default would be better, but then obtain
> consent if the user cares about it, and allow for backtracking, to go
> and change .perfconfig when the user realises the old output/behaviour
> is not really nice.
>
> But keeping the grass green as it used to be should be the priority.

So I don't understand what you are saying. If I have libcapstone
installed should the build link against it or just use its headers for
dlopen? Is declaring structs/constants to avoid needing the library
acceptable?

The patches as they are will link against libcapstone if it's
installed (just as currently happens) if not it will try to use dlopen
at runtime, if that fails then you get the current no libcapstone not
available at build time behavior. To support this a minimal amount of
structs and constants are necessary. See here:
https://github.com/googleprodkernel/linux-perf/blob/google_tools_master/too=
ls/perf/util/llvm.c#L21-L58
https://github.com/googleprodkernel/linux-perf/blob/google_tools_master/too=
ls/perf/util/capstone.c#L23-L132

The patches try to make it look as though the same function exists
with dlopen or directly calling by turning for example "cs_disasm"
into:
```
static size_t perf_cs_disasm(csh handle, const uint8_t *code, size_t code_s=
ize,
uint64_t address, size_t count, struct cs_insn **insn)
{
#ifdef HAVE_LIBCAPSTONE_SUPPORT
return cs_disasm(handle, code, code_size, address, count, insn);
#else
static bool fn_init;
static enum cs_err (*fn)(csh handle, const uint8_t *code, size_t code_size,
uint64_t address, size_t count, struct cs_insn **insn);

if (!fn_init) {
fn =3D dlsym(perf_cs_dll_handle(), "cs_disasm");
if (!fn)
pr_debug("dlsym failed for cs_disasm\n");
fn_init =3D true;
}
if (!fn)
return CS_ERR_HANDLE;
return fn(handle, code, code_size, address, count, insn);
#endif
}
```
That is with the library linked it is just a direct call otherwise
dlopen/dlsym are used. This means that the perf code using the library
is unchanged except turning "cs_disasm" into "perf_cs_disasm" and we
can unconditionally assume the perf_cs_disasm function will be
available.

If we don't create the structs/constants ourselves, which I think is
where controversy lies, then any function that calls cs_disasm needs
to handle a situation where there is no cs_disasm at build time. I was
trying to avoid this clutter in the code and just have things at the
library boundary. The structs/constants become necessary as we can't
assume we have access to the header file to support perf's current
build.

Thanks,
Ian
