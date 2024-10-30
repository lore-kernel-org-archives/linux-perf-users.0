Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2871BD9FA;
	Wed, 30 Oct 2024 19:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730315854; cv=none; b=Lg2FT0QlIOOEzIjf9J3cDQBDLjHxe/zClf6jBWiJrjQxAUGnrtTO5WSHO/FmiNtG2EoD58ML+iN4vygleXePgS1aeDdsnNmPQltkMJsriQsxhHCTqcBalpPKR9S/HGBxUa/ntrX8x1CLlxDhYyC+qd6ujXDI54m7Tre01O8ExnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730315854; c=relaxed/simple;
	bh=OB0SigpF9MF4WLA6zg9tdQ4S3E/qGpEaIraOAxh4yqU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cwu3M/etnBbOF5u27EynAs6gLjWDWw6yN2E8Cy6cz1CNF7qSinqS3g/36QbHdQhVwqV5dB9xabvvS7mXBrHVr6veEKESr6BlSzRzxJ+M1KaSNtTH7zDrV6NSKocv8HwTVRsRywtESjn5X93asDONrLXctEj1DU8M/lK0NItH/aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KRw9q0/3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KRw9q0/3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5B92C4CECE;
	Wed, 30 Oct 2024 19:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730315853;
	bh=OB0SigpF9MF4WLA6zg9tdQ4S3E/qGpEaIraOAxh4yqU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KRw9q0/3hbFABMXTX/2Ilysz3wBTtLAIrBx2srR+lW5tPwbvwCPj+9wLZlYu3hU8v
	 MTgMv8g4ZWt8SjoUpWYZiBaztRwGwGXya+ohCspLGeqLY/OV1v2St8Uy3RnkQS5NJl
	 cGvU/KYGI+xPL230lqHLe3s0+Op5aK27WtISXdQHBXqBpzGGYo3V9HHfd2Wyr6/TWm
	 vyv16afaBSw6+U7PiwS0LWjMwGN+kmkTCcEZ4C8ZLHQ7bz48drX9S7jO1aBPv7mhDx
	 /UwG6cLh8q1oybgrocQ/NaFUgPC3Ng6Oaq9VoSnzmnhPeq08ArjjDXbYJjMvfzuZtf
	 XG8Q8JiFNTlMw==
Date: Wed, 30 Oct 2024 12:17:31 -0700
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
	Sam James <sam@gentoo.org>, linux-trace-kernel@vger.kerne.org,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Florian Weimer <fweimer@redhat.com>,
	Andy Lutomirski <luto@kernel.org>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [PATCH v3 06/19] x86/vdso: Enable sframe generation in VDSO
Message-ID: <20241030191731.tqdw4nmd7htvfrua@treble.attlocal.net>
References: <cover.1730150953.git.jpoimboe@kernel.org>
 <ebc4e4a51af47cd1e9a1c515407410e1f69d224f.1730150953.git.jpoimboe@kernel.org>
 <b89bcb68-d010-4041-aacf-15b934675705@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b89bcb68-d010-4041-aacf-15b934675705@linux.ibm.com>

On Wed, Oct 30, 2024 at 07:20:08PM +0100, Jens Remus wrote:
> > diff --git a/arch/x86/entry/vdso/Makefile b/arch/x86/entry/vdso/Makefile
> > index c9216ac4fb1e..75ae9e093a2d 100644
> > --- a/arch/x86/entry/vdso/Makefile
> > +++ b/arch/x86/entry/vdso/Makefile
> > @@ -47,13 +47,15 @@ quiet_cmd_vdso2c = VDSO2C  $@
> >   $(obj)/vdso-image-%.c: $(obj)/vdso%.so.dbg $(obj)/vdso%.so $(obj)/vdso2c FORCE
> >   	$(call if_changed,vdso2c)
> > +SFRAME_CFLAGS := $(call as-option,-Wa$(comma)-gsframe,)
> 
> I have the impression this test might not work as expected.

I suspect it works fine on x86-64, since that was the first arch
supported, so --gsframe being supported also means x86-64 is supported.

But yeah, other arches (and x86-32) are a different story.

> Maybe the following would be an alternative test in the Makefile?
> 
> SFRAME_CFLAGS := $(call as-instr,.cfi_sections .sframe\n.cfi_startproc\n.cfi_endproc,-DCONFIG_AS_SFRAME=1)
> ifneq ($(SFRAME_CFLAGS),)
>        SFRAME_CFLAGS += -Wa,--gsframe
> endif

Looks good, though the ifneq isn't needed:

SFRAME_CFLAGS := $(call as-instr, \
		   .cfi_sections .sframe\n.cfi_startproc\n.cfi_endproc, \
		   Wa$(comma)--gsframe -DCONFIG_AS_SFRAME=1)


Though, if multiple arches are going to be using that, maybe it should
just be a config option:


diff --git a/arch/Kconfig b/arch/Kconfig
index 33449485eafd..676dd45a7255 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -446,6 +446,9 @@ config HAVE_UNWIND_USER_SFRAME
 	bool
 	select UNWIND_USER
 
+config AS_SFRAME
+	def_bool $(as-instr,.cfi_sections .sframe\n.cfi_startproc\n.cfi_endproc)
+
 config HAVE_PERF_CALLCHAIN_DEFERRED
 	bool
 
