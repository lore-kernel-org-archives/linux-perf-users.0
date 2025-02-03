Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92BC20CCDB
	for <linux-perf-users@vger.kernel.org>; Mon,  3 Feb 2025 17:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738603244; cv=none; b=JYUvRhOJFjwSSB/VZmiQuwtG2uW06jxZ/wRAlntyFmarM8//Gn7SZRRmzzjp1KiG3EaV3f4NCstobaiWlamLDauGGbUPBKii9XIC6C2fHgY/HU3ceWLPPtiL1eeTi8mXd/J1fpUrnsYpX88t7YIRyMWVvpzekHacuPzpQ9iwqG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738603244; c=relaxed/simple;
	bh=3xP1IvjSWBYoWzpo8OmosTBSRyAsu4KF9MunuP19acw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KCy9h8Ims8hn2RHqz79B+hASKYRpX84M1awpltLh33jri5ytxevQxfyc4nj4STWwN+3KsbKANcxpuQLDFkw/0xJm/80AAR5VDf6OQMGW3TvKInxSbsZmfUGqc9UZwrE+ELKHeJNJ52ev8qXiW1GURypybfnYaHQoZZ5/+GkYs1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uy/7deBN; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uy/7deBN"
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3a7dfcd40fcso305385ab.1
        for <linux-perf-users@vger.kernel.org>; Mon, 03 Feb 2025 09:20:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738603242; x=1739208042; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GAo66MeJPG41OMCLB4xovTFK9mZU/N+qHwtpMW9VlfU=;
        b=uy/7deBNIGH6xff6UtxXZxBMS0UZ2xaEQ4S/ARa3tCwm9IRy8s7E/FSHIUvZUzrIAw
         DPHTyX3czsRzN7krV2FCwM0o3CRee0I1dE+E5kxwzisHDQsW3uMIxzEwWBqpXb5F+iAr
         1o69YLJ7aadelbAj8dpfdYCMMDFGIh6TOqAdoyeEGo/ndK3V1FyKDrDXn2gKVeR6veOM
         rp2tUtOv6GURaoXzsQKl1aqaRG3xUFxgUoyXBamJDN4S57OQdCWwSArPCxM1hyq4Vn6n
         CtBGyZCenkZyJMM7wRgS9Hk0QoWN1UfeGSBW2zqiN7Pajves1T/+IPLP66qVFf/pcaqD
         Y8zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738603242; x=1739208042;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GAo66MeJPG41OMCLB4xovTFK9mZU/N+qHwtpMW9VlfU=;
        b=czbtnsG0eQFqfnqK+LYtf/rgsgMo8QWLPtfl9kl9+53kEDf5KN0MmkE964qLWAc5VX
         t93uV9mJdkKfoYhAwVca0x+uQhXDhX0LUfJZ1epuD2VB2JztKmv3+BjhqXxwgYLGx5/U
         JCR3GmIzPQQ+NPKpWbuiwBCFGAkLlFTAo9/AD7NIM8adPhD1QJET7hTjc6hd57EbtyK4
         5KnNUveJrsQrUKGsTCY6J91QvDPPqpVpFiJQfjTSIHlUdUh41ou2+c6HHjn5sybHkQCp
         oMS9tpfL3KKTWMFT7P4mLWx++n52Ap9AxbOHu/PTDRt3bju9U0Q4Dfo82ojW8MICxeV5
         zu1w==
X-Forwarded-Encrypted: i=1; AJvYcCXIvL8PMzmCVqGSxvn2u5R6WSTdRqnxncYUpZpW+TZZ4hHfFUippmZMbV7zps2iW/S+/Zt5EV+s4w0uQuBLTejl@vger.kernel.org
X-Gm-Message-State: AOJu0YyNMsdSCTn8kOMrOWVQ1TGz44PLGF2MJcqzPcO22ImVQ8bB2P9+
	k/OfSExomzFTAjmiErqv5yBD51vx3F48//vkCojBtuMLV5aI8J3Eessf/wBzxptx1EEm29lmSn8
	BsZHQgbHQWuQgSileqx9aOAOXArjdbJtmQlS6
X-Gm-Gg: ASbGncvwacMGexV39QrB0iwwkSqr5D2zXNFuDNbYXttGZXIYp0SURHZs/z0KPDiua+4
	PGoYfvKZiOrbBO9TUr5ptstnnpiJ+avOp5pNCKBD2RbzW0tF9sxIE5pB/xJGXsnGGSj/mYL+o7t
	crB18eU4+WEQO07Yps58CEs0A=
X-Google-Smtp-Source: AGHT+IEDTaSTgDB3XaZzRvmDNVy0dyF+FRY4l/I0bO093GEzFS7ah5J9eJBNgklT1LHjNbeayephmHaJMb0xFAvkHZ0=
X-Received: by 2002:a05:6e02:12e9:b0:3ce:471b:1ae4 with SMTP id
 e9e14a558f8ab-3d03eea05d3mr390285ab.5.1738603241707; Mon, 03 Feb 2025
 09:20:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250129193037.573431-1-irogers@google.com> <f500ef21-5c87-4c60-8453-d98ee637a60c@app.fastmail.com>
In-Reply-To: <f500ef21-5c87-4c60-8453-d98ee637a60c@app.fastmail.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 3 Feb 2025 09:20:30 -0800
X-Gm-Features: AWEUYZnNKh34RX7hctk5o6IG1sjeytGUFhAy-xCa5ENY2IXz5w8NpUhwDPHndLw
Message-ID: <CAP-5=fVJHV=JgR_FR91V6zcVnLXnakdoiNP4Y5j-+X72r2STmQ@mail.gmail.com>
Subject: Re: [PATCH v1] perf symbol: Add rust v0 demangling support
To: Daniel Xu <dxu@dxuuu.xyz>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	James Clark <james.clark@linaro.org>, Howard Chu <howardchu95@gmail.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 30, 2025 at 11:35=E2=80=AFAM Daniel Xu <dxu@dxuuu.xyz> wrote:
>
> Hi Ian,
>
> Thanks so much for working on this!
>
> Only did a quick skim. Seems like it'd be nice to reuse the official
> demangler now that we know about it. Will be interesting to
> see how that gets packaged for distros.

I think the best solution is to use the official demangler but in
general we'd like fewer rather than more library dependencies. For
example your initial comments were to work to make the coupling with
capstone and LLVM disassemblers more loose via dlopen:
https://lore.kernel.org/lkml/20250122174308.350350-1-irogers@google.com/

Thinking through the options (note I'm not doing Rust things and so my
level of skin in the game is minimal):
1) stay as we are - well this is a mess as there is no v0 support and
the legacy support comes from libbfd/libiberty.
2) option (1) plus this change cleaned up - there's still the mess
with the legacy support, which is probably more important given v0
isn't widely adopted.
3) wait for the official demangler to be packaged as a library and
depend upon it, add testing from here - solves legacy and v0 issues,
but brings in an extra library dependency to the build. Timeline not
clear.
4) "contribute"/copy-paste the official demangler into perf tree and
do like (3). Perhaps remove the forked file when a dependable library
exists (there's some precedent for this with how libtraceevent was in
and then removed from the linux tree) - solves the timeline, not great
to fork the official demangler, so far not heard from the author Ariel
Ben-Yehuda and I would strongly prefer they contribute rather than I
copy-paste it.

For (3) and (4) it is probably a good idea to engage the Rust folks in:
https://github.com/rust-lang/rust/issues/60705

Having broken Rust demangling seems like a high priority issue for the
perf tool.

[snip]
> On Wed, Jan 29, 2025, at 11:30 AM, Ian Rogers wrote:
> > +char *rust_v0_bdemangle_sym(const char *str)
>
> Typo? Extra `b`.

Ack. Will fix it but let's figure out if this code is even a plan.

[snip[
> > +     if (demangled) {
> > +             /* Legacy rust demangling input is already C++ demangled.=
 */
> > +             if (rust_is_mangled(demangled))
> > +                     rust_demangle_sym(demangled);
>
> In util/demangle-rust.c, I see:
>
>      * INPUT:
>      *     sym: symbol that has been through BFD-demangling
>
> Perhaps double check that cxxabi is sufficient and update the comment?

I've not tested this change beyond making it pass the tests the change
contains, that are based on the v0 specification's examples. I believe
this/legacy may be working as most C++ implies libstdc++ which I
believe uses libiberty in cxxabi, so BFD demangling. Given the
popularity of libstdc++ I imagine things like LLVM's libcxx will try
to be compatible. Perhaps if there are examples of legacy Rust symbols
we can add a test?

Thanks,
Ian
