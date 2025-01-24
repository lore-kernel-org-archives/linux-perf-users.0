Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85718FBF6;
	Fri, 24 Jan 2025 16:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737737778; cv=none; b=llry0FSMATlwWhqwNt5QEMhoh7Lx3N+PD57tg8XMRL2UfQMN5VW3RQ+MfT7UPutTG4zcL8VBgamsvcBaK58h8Y0lNObFWcsmN3G12g8y3PcCHQgaNvx1ThTyI8pZjZrMMAXXMwiPTEr1f/t6ajyJ5OWS87Y16P1L9bxO9p3V24Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737737778; c=relaxed/simple;
	bh=+2/cfZrAdySIv4uxUP30BP1I7KomzUj4dyKI6FzDFUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OqbwLCwHaCsTg4tpQp0iS6EGOiY1jR25KsL3KcRawo2yyMm6ehpLr/G9Z7Stx0FyxVtYMlJO+WEhP88W+rnW2Jy+MNm3einsoq4vfgAg5zIEInX7ixTJiCPTXMKiB+oGURWCW2LkMs3h2FVwTonkmTfyWMTSyn+k9ozWisUlojA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=stP8cjQy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="stP8cjQy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7041C4CEDD;
	Fri, 24 Jan 2025 16:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737737773;
	bh=+2/cfZrAdySIv4uxUP30BP1I7KomzUj4dyKI6FzDFUY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=stP8cjQyDn69zOqi5pyOqrzSIcgzgVdApIA6AvZZrmWM+SKPll1gtM72kwSmf4Q9F
	 AoOlzx+75boRzPM2EMDQy3Pqe67Dux9M+UJBPd4wOrRVDm4BOl71zHxXM1s6v2g9k3
	 4BGO1cVnwWVT/iIbUhDRiZwIOT6wiURqKh9dWnrA4NVuS+8C6VHw5MYwiUfrv4kYQ6
	 PiJ1XpiOlisINHFre4S/lsv9DQ2E11HrDT4FwEamc/XP/mMOQJ8kBCYLbG9lPY+Cxg
	 FBqKY4pE6ad7H0jq3zY80iJI/su25gXYAZWoLSDXwgfCtEEKubN4nz6p5DXkifpRXw
	 zpi113xiYR6Qw==
Date: Fri, 24 Jan 2025 08:56:11 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Jens Remus <jremus@linux.ibm.com>
Cc: x86@kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	linux-kernel@vger.kernel.org, Indu Bhagat <indu.bhagat@oracle.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org, Mark Brown <broonie@kernel.org>,
	linux-toolchains@vger.kernel.org, Jordan Rome <jordalgo@meta.com>,
	Sam James <sam@gentoo.org>, linux-trace-kernel@vger.kernel.org,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Florian Weimer <fweimer@redhat.com>,
	Andy Lutomirski <luto@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Weinan Liu <wnliu@google.com>, Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [PATCH v4 09/39] x86/vdso: Enable sframe generation in VDSO
Message-ID: <20250124165611.qgp765fhqi6fm72g@jpoimboe>
References: <cover.1737511963.git.jpoimboe@kernel.org>
 <c93fbd53f01c2c86f747af27040ac11f16dee032.1737511963.git.jpoimboe@kernel.org>
 <05ae2b86-ba4c-4eaf-9c5f-726fc57c7a2d@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <05ae2b86-ba4c-4eaf-9c5f-726fc57c7a2d@linux.ibm.com>

On Fri, Jan 24, 2025 at 05:30:36PM +0100, Jens Remus wrote:
> On 22.01.2025 03:31, Josh Poimboeuf wrote:
> > Enable sframe generation in the VDSO library so kernel and user space
> > can unwind through it.
> > 
> > Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> 
> > diff --git a/arch/x86/entry/vdso/Makefile b/arch/x86/entry/vdso/Makefile
> 
> > @@ -47,13 +47,17 @@ quiet_cmd_vdso2c = VDSO2C  $@
> >   $(obj)/vdso-image-%.c: $(obj)/vdso%.so.dbg $(obj)/vdso%.so $(obj)/vdso2c FORCE
> >   	$(call if_changed,vdso2c)
> > +#ifdef CONFIG_AS_SFRAME
> > +SFRAME_CFLAGS := -Wa$(comma)-gsframe
> > +#endif
> > +
> 
> You probably erroneously mixed up C preprocessor and Makefile syntax? :-)
> 
> ifeq ($(CONFIG_AS_SFRAME),y)
>        SFRAME_CFLAGS := -Wa,--gsframe
> endif
> 
> $(comma) does not appear to be required in this context.

Yeah, before it was in a Makefile macro which needed the $(comma) to
distinguish it from the macro arguments.

-- 
Josh
