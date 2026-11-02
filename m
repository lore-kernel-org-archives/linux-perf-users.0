Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793606344;
	b=Y0py76niUbmZhY9ALNMLBrj89ZZIbZEs9+H31VmKVxN7fooGNv4/ptjdX0tYffaVj3v9
	 2GLS24vx7ONFcrA8EI2rAVwN8hltmNnkMxkp6euhuMff6kEdiOF+HhcJxsiPcL2SGxRaE
	 3cT11joxlzcGsp7n1Fk89gtN3ZTrmRuGRjUaSHo1aMyvwOaZvduyOeMbzWyAafm5BZ98r
	 8TZpWnespUOBWsI4p+VHi46VxBljT4HoNRyhr+ybYNVhQgD9Mcio6oo5r6v8hKEJvv2dz
	 zu1HeZw7mpH7ur50oyuyFgHZge2pjyPhmaFAKTT9XrMtZRaVGov7ha31DDloXI8O25A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793606344;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=dcr4y+Sj+ZpaCAZ+Dc0GBZtVMxTO09cIIcWglh3GQfg=;
	b=DnyDvoSrpCSOauibnBcknTyYJwgf8OcMJ2c+4H/dDl+Vud2ESHjr3NJZV8ZSHT/GF0XW
	 qHZBhbMUJNcVFJGFe02DHIbJSzIF1o8gjIxrnPwm/Bt2goh35LovuXIrK5n8aGcDi50OZ
	 OPskbgj0lYfnaDCaZ2SkQRAsycXrLNXVXXQIZOhaBv7/68tZzN6xfvhIbJw7g11ISP/zt
	 q7NG9p6RabLJZEFOCqVZBNB2+tssAIxxM7ua95DpIsE6jSXaf95NoNXhjbaPzrhuQE/f6
	 uplU7xDLk02UFOzJn6nvcxQffUP+zQhTRjy4C+vnECHo13RVP2bARKVlC5s0F9RLO4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MGj1+vKP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A651606A327
	for <linux-perf-users@vger.kernel.org>; Mon,  2 Nov 2026 07:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MGj1+vKP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5E751F0093A;
	Mon,  2 Nov 2026 07:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793606344;
	bh=dcr4y+Sj+ZpaCAZ+Dc0GBZtVMxTO09cIIcWglh3GQfg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MGj1+vKPF0TYfrSdLTE/XtUdFjHwxz9z3tT4gZ5CG0JppczZNPJC7exn5kKuf0bkP
	 EaukMzyRng6V9mkWo100dQZkmccu7J3Yhe6D94wfNlv8fm2C8z352B90IMHfrjnCkh
	 mFqAl0TihCGJsjxzK9W3B6rujCIVZ8K3Mg8mor14FrVgmv4EmK4vUt76B0LeO2hbA9
	 tiX4AEzhfNzP+YiZs7cIZb8VpIXjj7UXNoAy7L50jIRTksOdZoFIJ7ZU7p2tNVehg2
	 NL8CdAIx4fu5/GmMVfnJFZNrSnmVxmBhF32WkYO5jfVhrGXE3BmY3HHhRI7alFjMjN
	 IwsiQ357Cf6qw==
Message-ID: <sashiko-outbox-193065@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/6] perf/x86/intel/pt: Stop tracing if VMXON has not
 yet happened
Reply-To: sashiko-reviews@lists.linux.dev
To: "Adrian Hunter" <adrian.hunter@intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261102074039.26983-3-adrian.hunter@intel.com>
References: <20261102074039.26983-1-adrian.hunter@intel.com>
 <20261102074039.26983-3-adrian.hunter@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 07:59:03 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> On Broadwell, which does not support Intel PT in VMX operation
> (IA32_VMX_MISC[14] =3D 0), VMXON clears IA32_RTIT_CTL.TraceEn and any
> subsequent write to IA32_RTIT_CTL causes #GP.
>=20
> To avoid that, intel_pt_handle_vmx() sets pt->vmx_on so that
> pt_config_start() and pt_config_stop() skip writes to
> IA32_RTIT_CTL while VMX is active.
>=20
> However, pt->vmx_on is set before VMXON executes. An NMI in the window
> between setting pt->vmx_on and executing VMXON can then observe
> vmx_on =3D=3D true while tracing is still enabled.
>=20
> In that case pt_config_stop() skips the write that would clear TraceEn,
> leaving tracing active. This can subsequently cause:
>=20
> [ ... ]
> 	 kthread+0x2cb/0x3a0
> 	 ret_from_fork+0x5ff/0x7f0
>=20
> Fixes: 1c5ac21a0e9b ("perf/x86/intel/pt: Don't die on VMXON")
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102074039.2698=
3-1-adrian.hunter@intel.com?part=3D2

