Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4EA3264FF
	for <linux-perf-users@vger.kernel.org>; Thu, 12 Mar 2026 00:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773274569; cv=none; b=ua9eN+L7WzX40ssLMb0KsToxgwI+e6W6oWZNIQXLAIj/MxbT8mnpHBxhkFS5PZG64seV4+DtQ91Wx23yYSWoiz38txHsTLjaTUeJQwXVTL/RquCa83V6DU7vYTOKmY9wggG7eK5OTMbapiTAYRieQVR7WqqFJr2mBj8PXmdJAts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773274569; c=relaxed/simple;
	bh=v4zcyFwLddeczA8kJLb832z7ZBDX94bYAHurxSf86Y0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s0TxKptTfP/DmbF/3MOgrH3fz57pJrJs1zFs6TWC4ecCQdYp3TLUIC2niQ/Gq7fLusWdFV2xKI3BpigqyhhfyUNZJC+GsE+lR/Ss+B23KqBeMVS7IeBH4BDrKsEzVWyTWbhTXPUSxbCKfNMIgfXS1Ih0GEIvb3WNe0Gz1IHVxYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pONldkPL; arc=none smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pONldkPL"
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-1270fc2bdf2so5567c88.0
        for <linux-perf-users@vger.kernel.org>; Wed, 11 Mar 2026 17:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773274567; x=1773879367; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bMrrvcXulRZkoBfi9FaZ3WzGUIx2J4qRVHmF1FKtVWA=;
        b=pONldkPL05aKfO667Ol4iLMqhGZ2Y5pcNSWnzsTkzjNCMGYAmc0PwBTf3i53hHtOBR
         1AcqGsddJBzlqM9belDRP/5CILcSl6egJo5MxDwNv/CfqCo/m0mwQjp2ltSh3WIB/490
         ie7H7SfFHxq8Exvob4onXXg8frlQPJiCZRNnXuLdtDCvCA/H+rVseLEnURVD+a0VKJBu
         l03LjRCRkLB2l3DsmXJX5dxl6FLntkgI0BPQitPpsn7NhkNbhUfwf038wiZ509anx0lb
         oG5oCw0M1uJ/Oh4waNJU5DCvtgBPQC2S7v+XbdP/G0bqy+KCTphXiqadq7hrsa05LBgB
         R63g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773274567; x=1773879367;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bMrrvcXulRZkoBfi9FaZ3WzGUIx2J4qRVHmF1FKtVWA=;
        b=kSl96ZuEcz+oDgLuEu8opOcAPVpoFei2X0U7wFhbuF6hcf3KsBKxSO/ilW0mbGvOh0
         WQqYUEvRQy0tvlNUYAde+IXdUYG849GQhYKH8QsCSa1cGVw30wLn7s2/KAfuJir+zZE+
         ipiCfjGc9EKCyK1LTweOPVfDZ3aoKdFxNccnQ7XgxJq6kCkhu0TBDdrINtq98obIamjn
         +jCLrstF6+/Cw209xXkCVFGi45xmIjpgowoRbgJD9msDZK+EOlb2YR1Fe8ezL3tOQ6El
         0GXQHg74IyZpJzqi5i7N6V2gPom0YSgNxfwNV3c0DxU8yUwc7ZjmA68EkKs4cPwR+e55
         DOoA==
X-Forwarded-Encrypted: i=1; AJvYcCXYAZXMkJF7EL+mIrZKAtTGoiuXIFCNuS25I7hVvSSznPMH/9Yi1nhkLo3GjJ9L8qq/wYXia4rXcQrSFjz2jzqb@vger.kernel.org
X-Gm-Message-State: AOJu0YwfaLHOpd0u4vl0SLBIgXAsP8hsEuxL/5FcpYMS/ayHgTGjgsiX
	3EPxhFXDDuU2l1NcwvcNgFVtJ33ORa06BQefcGiFQeQz31qqFMwNEC/aZdS8Kh2xZA==
X-Gm-Gg: ATEYQzyGt2R+W7mt4jMU7X3WNBwrRvEOkdHhYcCiLvnAOiLZXT3pOVvI2CECL3VDRYY
	DTeGkzil9mCGJ/oTIYDAWYdmuz8mJ55bgBisvqIy71gQq4Ry/pnDBG/V7y6DRhTVTpDDYr68EY4
	3uVy0v7guAQoz/Hk5K+/cfdKYXbshCqXI1l5DX6KDEQryMYms6Zl4b2N6X+dAPVN1dfYUf66Wx/
	BZy7NaT7M2xAK5KTlN9EviVDpMK/hkuuvZjg12JNZJ7aRw+hbPLRq3GgUtx6Us/9HuOHvT+tnkI
	H1vyPH0CfisrtbxSXcMFVtgxeZ8HV2p70zZ8FBIomewFNFEPb3BE0vKbMvpaleKwnPYckMbR0Vg
	1N8iGzyRusHtdiuQCgrW8TKDFcDt6rIciAIRbzLEMWZnDhIEEaEaCqYdVlhDh33ypTycXR4eo7n
	9BETXWJsWEdFoLqUTerm1vengdcC5BwGE+/mdXVwgMY8ehVrjNr2EwH6uvO85PYQ==
X-Received: by 2002:a05:701b:4243:20b0:119:e55a:808a with SMTP id a92af1059eb24-128edc2f354mr29180c88.7.1773274566569;
        Wed, 11 Mar 2026 17:16:06 -0700 (PDT)
Received: from google.com (154.52.125.34.bc.googleusercontent.com. [34.125.52.154])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2be8aa4ecbdsm4377079eec.16.2026.03.11.17.16.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 17:16:06 -0700 (PDT)
Date: Thu, 12 Mar 2026 00:16:01 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Sami Tolvanen <samitolvanen@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Jason Baron <jbaron@akamai.com>, Alice Ryhl <aliceryhl@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ard Biesheuvel <ardb@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Kees Cook <kees@kernel.org>, Linus Walleij <linusw@kernel.org>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Nathan Chancellor <nathan@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
	Jens Remus <jremus@linux.ibm.com>, Juergen Gross <jgross@suse.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	David Kaplan <david.kaplan@amd.com>,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	James Morse <james.morse@arm.com>, Thomas Huth <thuth@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>, kernel-team@android.com,
	linux-kernel@vger.kernel.org,
	Will McVicker <willmcvicker@google.com>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>,
	"moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)" <linux-arm-kernel@lists.infradead.org>,
	"open list:PERFORMANCE EVENTS SUBSYSTEM" <linux-perf-users@vger.kernel.org>
Subject: Re: [PATCH] static_call: use CFI-compliant return0 stubs
Message-ID: <abIFwSF1RqhC96C2@google.com>
References: <20260309223156.GA73501@google.com>
 <20260311225822.1565895-1-cmllamas@google.com>
 <20260311231406.GZ606826@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260311231406.GZ606826@noisy.programming.kicks-ass.net>

On Thu, Mar 12, 2026 at 12:14:06AM +0100, Peter Zijlstra wrote:
> On Wed, Mar 11, 2026 at 10:57:40PM +0000, Carlos Llamas wrote:
> > Architectures with !HAVE_STATIC_CALL (such as arm64) rely on the generic
> > static_call implementation via indirect calls. In particular, users of
> > DEFINE_STATIC_CALL_RET0, default to the generic __static_call_return0
> > stub to optimize the unset path.
> > 
> > However, __static_call_return0 has a fixed signature of "long (*)(void)"
> > which may not match the expected prototype at callsites. This triggers
> > CFI failures when CONFIG_CFI is enabled. A trivial linux-perf command
> > does it:
> 
> *sigh*...
> 
> And ARM64 can't really do the inline thing because its immediate range
> is too small and it all turns into a mess constructing the address in a
> register and doing an indirect call anyway, right?
> 

Right, the range for the jump is very limited. I _think_ tracepoints
have managed to implement the trampoline work-around:
  arch/arm64/kernel/ftrace.c

So it looks do-able I think but a much complex route.

--
Carlos Llamas
