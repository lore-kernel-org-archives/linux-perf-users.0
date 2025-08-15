Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B40270548;
	Fri, 15 Aug 2025 20:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755288179; cv=none; b=c+Bo+hIKyZn3VhabghVPVpx33upVPOYtkEuhWDPhPYA738n2Jg5amIqLr6imKHWNRT4EFMfkHMRBqqORFMrhTSg388PM+/Y6prgJjyZah0XUfl+Tmvc3iVkH0M+/dRsD3CF3K2wIq8KuXjhUe1uNeawiEOmmYlgHt9fRNoy3rx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755288179; c=relaxed/simple;
	bh=be6Z+JaouOJVE3f+RWzpBxVj1NE79aYm+OuV+AsEfnY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gOaxTAtPc1GVnMGhuX9U0feAMb0acnOegoaEkLPvl4anEp+Wys1E2eka0rU0TIsZSIja0IBLSkDFbVpt+NlAXJKjkg/4WWrkPo52v1oe9e679xegOfL8xOU/wTh7kcGOZDmmrjsSjj2KxmqZpX8cjPfZmi5wzVfEFuJyVeFOhrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KgrZhln9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KgrZhln9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC057C4CEEB;
	Fri, 15 Aug 2025 20:02:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755288178;
	bh=be6Z+JaouOJVE3f+RWzpBxVj1NE79aYm+OuV+AsEfnY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KgrZhln9EWqW26u3laNIrqswrW3VFQLifij7Y8RzhmCLnPLEED92ekMhguM835om5
	 4UbDVkTmZ1dU88wfQymmXaTAty2c76ksxpxfrfaquF9jbiB37RGuX1snx+GxAzlsMg
	 1YDFD9ZTOUo9KixQrNUS7k/r0m2lo1mD7M3+CU5crMMOEceN1KdrF0+VGXWOMjgx+t
	 XrW+Em64tmvZAaUTJ+8N5pxdYWv7PkjSzDEEPwy8C1codCaGYzs4HxnPP9rf1UhdaJ
	 QCpn5uOBpSkaH8whe0qEdMH8YJQioRrMalTB8ixx7lFopCu0mlYthAZ92XS1VdxbgI
	 eT90vNihdy6sg==
Date: Fri, 15 Aug 2025 13:02:56 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Suchit Karunakaran <suchitkarunakaran@gmail.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, paul.walmsley@sifive.com,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
	guoren@kernel.org, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-csky@vger.kernel.org, skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH RESEND] perf/util: make TYPE_STATE_MAX_REGS
 architecture-dependent
Message-ID: <aJ-ScOp3ZCG6PQmD@google.com>
References: <20250815182742.45541-1-suchitkarunakaran@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250815182742.45541-1-suchitkarunakaran@gmail.com>

Hello,

On Fri, Aug 15, 2025 at 11:57:42PM +0530, Suchit Karunakaran wrote:
> Replace the fixed definition of TYPE_STATE_MAX_REGS with architecture-
> specific values for better accuracy across multiple CPU architectures
> including PowerPC, ARM, x86, RISC-V, MIPS, and others. This change ensures
> the type state registers array size matches the actual register count of
> the target platform.

Thanks for the patch.  Unfortunately we support x86 and powerpc only but
this looks like good information for later work. :)

Thanks,
Namhyung

> 
> Signed-off-by: Suchit Karunakaran <suchitkarunakaran@gmail.com>
> ---
>  tools/perf/util/annotate-data.h | 45 ++++++++++++++++++++++++++++++---
>  1 file changed, 41 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/perf/util/annotate-data.h b/tools/perf/util/annotate-data.h
> index 541fee1a5f0a..0dfb12a8f1cc 100644
> --- a/tools/perf/util/annotate-data.h
> +++ b/tools/perf/util/annotate-data.h
> @@ -189,11 +189,48 @@ struct type_state_stack {
>  	u8 kind;
>  };
>  
> -/* FIXME: This should be arch-dependent */
> -#ifdef __powerpc__
> -#define TYPE_STATE_MAX_REGS  32
> +#if defined(__powerpc__) || defined(__powerpc64__)
> +#define TYPE_STATE_MAX_REGS 32
> +#elif defined(__aarch64__)
> +#define TYPE_STATE_MAX_REGS 31
> +#elif defined(__arm__)
> +#define TYPE_STATE_MAX_REGS 16
> +#elif defined(__x86_64__)
> +#define TYPE_STATE_MAX_REGS 16
> +#elif defined(__i386__)
> +#define TYPE_STATE_MAX_REGS 8
> +#elif defined(__riscv)
> +#define TYPE_STATE_MAX_REGS 32
> +#elif defined(__mips__)
> +#define TYPE_STATE_MAX_REGS 32
> +#elif defined(__sparc__) || defined(__sparc64__)
> +#define TYPE_STATE_MAX_REGS 32
> +#elif defined(__alpha__)
> +#define TYPE_STATE_MAX_REGS 32
> +#elif defined(__s390__) || defined(__s390x__)
> +#define TYPE_STATE_MAX_REGS 16
> +#elif defined(__sh__)
> +#define TYPE_STATE_MAX_REGS 16
> +#elif defined(__nios2__)
> +#define TYPE_STATE_MAX_REGS 32
> +#elif defined(__hexagon__)
> +#define TYPE_STATE_MAX_REGS 32
> +#elif defined(__openrisc__)
> +#define TYPE_STATE_MAX_REGS 32
> +#elif defined(__csky__)
> +#define TYPE_STATE_MAX_REGS 32
> +#elif defined(__loongarch__)
> +#define TYPE_STATE_MAX_REGS 32
> +#elif defined(__arc__)
> +#define TYPE_STATE_MAX_REGS 32
> +#elif defined(__microblaze__)
> +#define TYPE_STATE_MAX_REGS 32
> +#elif defined(__xtensa__)
> +#define TYPE_STATE_MAX_REGS 16
> +#elif defined(__m68k__)
> +#define TYPE_STATE_MAX_REGS 16
>  #else
> -#define TYPE_STATE_MAX_REGS  16
> +#define TYPE_STATE_MAX_REGS 16
>  #endif
>  
>  /*
> -- 
> 2.50.1
> 
