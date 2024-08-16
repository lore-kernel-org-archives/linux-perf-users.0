Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 561B31BF331
	for <linux-perf-users@vger.kernel.org>; Fri, 16 Aug 2024 13:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723815935; cv=none; b=QRPYdTWi8vbU+sEA37QVegcFFztv0jgBvBzaXeqVvBFSmRQACB2BDfxZec0HsVuRm7ddN6JASybv7fFsLeKNR6AaI3DPsug6NlakhvNNS05+bgN0oEZ+fthRXjlpTd1um2D7vVSZqN9xv+NHilqrQ2EgtSd5uUbD6axjuoy90zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723815935; c=relaxed/simple;
	bh=IgZeBEc3jzEvnzkGG3pWc342VNR8qaLJYk94l4KKzAM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=De6GV1rz3tXvp3LNiemd2+TOkNfzDPDbNiG0eX6XNEZCZ1SNLFh7d3PfvZhUiE1g2hGz4jFyVw8it53P2wbJEoM3ErbMaR49gitKYdKivPBSb3sjw2IvqWX572wu/jQPWKJ9QgJyGDlN2EhOdmqLx/r+dFg7p3GKdBkBnisdAsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GfnoTSEm; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GfnoTSEm"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-650fccfd1dfso33056087b3.0
        for <linux-perf-users@vger.kernel.org>; Fri, 16 Aug 2024 06:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723815932; x=1724420732; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=G85pWzgAjDzHJOUxuuipVYtZwpIJzJ8wQdXPRG+9C/o=;
        b=GfnoTSEmk5qxTE3i5/KgMcDH/WZVbevLMF4CyU6V72gYLO8ySri9N2AS7/1Q1ca1uP
         hjbcz95nGevwYLTanXunSNkk9jDR3Mn5PHoyDTXmc++Z2XYDCdWTqKhCG48UY3PVgoTa
         pesH0P50qkQzI0p8C4khxrXl09cHyK2pB0CftGKiOwc8bm5qF9ObW4FS7RsrtucQvOf5
         kl2i5cx5mhxHMiGleC8HcNvo62KcbuCO62xWyETHitR2hpD+wzQSmY9lLW7m/8iyb8Cu
         Hi0TILCojeADewxef7gQlAtu+vdWZQZw18RoOeiZQRhG2YM9tUTWHsGCVh3eyEr3aLEu
         ueBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723815932; x=1724420732;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G85pWzgAjDzHJOUxuuipVYtZwpIJzJ8wQdXPRG+9C/o=;
        b=dlS5TjYj64eg9G3HUSllJ4U2VOrxicKeHJseq4TeuxDhXY2xOMcl4NZx7vGQla7vw6
         5zN8XzpicL8m8DcXoDXR/jevtMcWwlOCZpyYaVT4RKHoYRxaRk6jWgPpkmjHPKGHk4U5
         oNceosZFpdCsDx3XuxAV3DZiYvgh8V0MSEMo1QCYLnOolfF4jBSJa4wZ30cReiLeZ8Yr
         AFCskoV0p4Iz27FG/NywDw7cEuWLyFkkS3czFVEii2QBOhCPg0QIlLavNKRasrkP/auB
         6FNprBPMMsThQiWcjFjhSW8INqYOALHEVaPsYwM93oHSyGiXktN5YMCtkOZU1YQMBkEp
         q6Qw==
X-Forwarded-Encrypted: i=1; AJvYcCWxywnaPUHC6Lt7PEqVMbUhi6C6yMOJ3Y/Oi7fmpkrSsGW6t4VZnmpgrbGt6KuVam62tABwqSf+rY/2qEvaVQtdM+J+3+gjwawrihBStXZRSA==
X-Gm-Message-State: AOJu0YylKMg0Xl7tfEXNgHIi3uoW3P5kcGIbou5Lb6SamBGzrX2Vufak
	OycM4eqQHttgYlzL1GFpVX04YifGThuAwzJPpEu8+Y54N6V+zxdDPZZcseNY/Opo+1vFBk9ON5j
	tZw==
X-Google-Smtp-Source: AGHT+IFxTi/w4NwmmEulgecgXhpEeAJRtdL2wE03PZ6n2HXJbG4Pi8//pjifBnclwhl2cdQ13xp4iA6hJFg=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:11:b0:e0b:fe07:1e22 with SMTP id
 3f1490d57ef6-e1180e61040mr14467276.1.1723815932258; Fri, 16 Aug 2024 06:45:32
 -0700 (PDT)
Date: Fri, 16 Aug 2024 06:45:31 -0700
In-Reply-To: <20240709143906.1040477-10-jacob.jun.pan@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240709143906.1040477-1-jacob.jun.pan@linux.intel.com> <20240709143906.1040477-10-jacob.jun.pan@linux.intel.com>
Message-ID: <Zr9X-08zsOKFlvkB@google.com>
Subject: Re: [PATCH v4 09/11] x86/irq: Enable NMI source on IPIs delivered as NMI
From: Sean Christopherson <seanjc@google.com>
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: X86 Kernel <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Dave Hansen <dave.hansen@intel.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Xin Li <xin3.li@intel.com>, linux-perf-users@vger.kernel.org, 
	Peter Zijlstra <peterz@infradead.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Tony Luck <tony.luck@intel.com>, Andy Lutomirski <luto@kernel.org>, acme@kernel.org, 
	kan.liang@linux.intel.com, Andi Kleen <andi.kleen@intel.com>, 
	Nikolay Borisov <nik.borisov@suse.com>, Sohil Mehta <sohil.mehta@intel.com>
Content-Type: text/plain; charset="us-ascii"

On Tue, Jul 09, 2024, Jacob Pan wrote:
> Program designated NMI source vectors for all NMI delivered IPIs
> such that their handlers can be selectively invoked.
> 
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> ---
> v4: Enhance comments, no functional changes (Li Xin)
> ---
>  arch/x86/include/asm/irq_vectors.h | 10 ++++++++++
>  arch/x86/kernel/apic/hw_nmi.c      |  3 ++-
>  arch/x86/kernel/apic/ipi.c         |  4 ++--
>  arch/x86/kernel/apic/local.h       | 18 ++++++++++++------
>  arch/x86/kernel/cpu/mce/inject.c   |  2 +-
>  arch/x86/kernel/kgdb.c             |  2 +-
>  arch/x86/kernel/nmi_selftest.c     |  2 +-
>  arch/x86/kernel/reboot.c           |  2 +-
>  arch/x86/kernel/smp.c              |  2 +-
>  9 files changed, 31 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/x86/include/asm/irq_vectors.h b/arch/x86/include/asm/irq_vectors.h
> index 4f767c3940d6..9b7241e7faa3 100644
> --- a/arch/x86/include/asm/irq_vectors.h
> +++ b/arch/x86/include/asm/irq_vectors.h
> @@ -135,6 +135,16 @@
>  #define NMI_SOURCE_VEC_IPI_TEST		8	/* For remote and local IPIs */
>  #define NR_NMI_SOURCE_VECTORS		9
>  
> +/*
> + * When programming the local APIC, IDT NMI vector and NMI-source vector
> + * are encoded in a single 32 bit variable. The top 16 bits contain
> + * the NMI-source vector and the bottom 16 bits contain NMI_VECTOR (2)
> + * The top 16 bits are always zero when NMI-source reporting feature
> + * is not enabled or the caller does not use NMI-source reporting.

This is *extremely* misleading, bordering on being an outright lie.  The vectors
are not encoded in a single 32-bit variable when programming the _local APIC_,
that is 100% an arbitrary software construct.  The actually write to APIC.ICR
morphs bits 15:0 into the TYPE, and the bits 31:16 into the VECTOR.

> + */
> +#define NMI_VECTOR_WITH_SOURCE(src)	(NMI_VECTOR | (src << 16))

Why require callers to use NMI_VECTOR_WITH_SOURCE instead of having macros to
directly encode each source NMI, a la APIC_PERF_NMI?

To me, this:

				__apic_send_IPI(cpu, NMI_VECTOR_WITH_SOURCE(NMI_SOURCE_VEC_IPI_SMP_STOP));

is *way* harder to read/parse than:

				__apic_send_IPI(cpu, NMI_VECTOR_SMP_STOP);

especially since that first one blasts way past 80 chars (yeah, I know 80 is now
a soft limit, but it's still nice to keep line lengths short when possible).

> +#define NMI_SOURCE_VEC_MASK		GENMASK(15, 0)

IMO, this is an absolutely awful encoding scheme.  Vectors are 8-bit values, so
why on earth use 16 bits?  And @vector is passed along as a _signed_ integer,
which means 32-bit kernels could end up observing negative values, which probably
isn't problematic in practice, but it's unnecessarily confusing.

All this FRED stuff is hard enough to follow given the specs have been rolled out
piecemeal (someone at Intel must get paid based on how many specs they publish),
using a software-defined scheme when FRED is already overloading a decades old
hardware-defined encoding is just mean.

Why not encode APIC_DM_NMI straightaway?  You're already making it a hard
requirement that the backend (__prepare_ICR()) be able to handle a @vector that
has bits 31:8!=0.  I don't see how the above scheme provides any value.

Side topic, APIC_DM_FIXED_MASK should really be APIC_DM_MASK, that "FIXED" part
is completely wrong.

E.g.

static inline unsigned int __prepare_ICR(unsigned int shortcut, int vector,
					 unsigned int dest)
{
	unsigned int icr = shortcut | dest;

	/*
	 * Callers are allowed to encode the NMI delivery mode directly, which
	 * allows using the vector field to provide the NMI source (FRED only).
	 */
	if ((vector & APIC_DM_MASK) == APIC_DM_NMI) {
		icr |= vector;

		/*
		 * Pre-FRED, the actual vector is ignored for NMIs, but zero it
		 * if NMI source reporting is unsupported so as not to risk
		 * breakage on misbehaving hardware/hypervisors.
		 */
		if (!cpu_feature_enabled(X86_FEATURE_NMI_SOURCE))
			icr &= ~APIC_VECTOR_MASK;
	} else if (vector == NMI_VECTOR) {
		icr |= APIC_DM_NMI;
	} else {
		icr |= APIC_DM_FIXED | vector;
	}

	return icr;
}

and then NMI_VECTOR_SMP_STOP would be (APIC_DM_NMI | NMI_SOURCE_VEC_IPI_SMP_STOP).
