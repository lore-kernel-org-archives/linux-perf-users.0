Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91002184540
	for <linux-perf-users@vger.kernel.org>; Fri,  3 Jul 2026 12:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783082903; cv=none; b=naGLpbf9tLU+kb7feNc1jErchR0S4lo/oomxfcD5ObKMyS5IDmxgS154trxY6GP6+fLOoWbem3G7pcmGFsaVkbuBhmr76RH/4Yfb7eUDZGW1BGPMeLvzJ5XgM+eolU1jO+8a3Peyi4IFXEAPNGjYgqXugyS9nk3rizqQPyxHeww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783082903; c=relaxed/simple;
	bh=dceXvne/nCelBiKqglaEc9x7f2WnQBmzW+j2d9dOBQE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Sy0wVSCb1WmOnZMrPdK6wPE4OM1iGC2/aXTi0sclH9LY2ojxA64CqE9X7aWX4pd8xtGlZps9bgBruogrOHkZqPu+Dg/cuQEmebNDg25EKp7itcsD1aCflbn0OMTNUQBNe0Afgr1LlyQt5dwM41hUmZTSaAlau/ycYxDrTQiVG+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RzosZcZ+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RzosZcZ+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 130081F000E9;
	Fri,  3 Jul 2026 12:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783082902;
	bh=+2rgJJTrIiJpMKCp9FnEe5FXYmvE0Z11ZehcXLdhtnQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RzosZcZ+KUxn2fDnKgWHIwK4JbdyDW89pQ71Uwy0DnZqprE0b6WdpS1fJARaeUq9T
	 FdZIQxBDViN+OIiRGL9BGnuMyHia1b41/c3B6RZRvBgqycg0fOXF60J9XUG+d7DqE8
	 1H/MrYN4T9WADPgVrQmWqSokwG3N7Q/azCia9dkhmW7vXy7rFmqD3OdlIfmagqH2nU
	 DOIqgbt/+KHz1me9f6+MyBGLvg0A+Swg5d8800F1bV956d+hhWucyV4qvSE1fTEfh3
	 8SfNXIKMH03F2Duf7iOsxzjMRrRvS7EqTPjSFAChhmbHksFAfN17jvKBx/i0OV4CfR
	 WH7QNzmQHPO3Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4] ARM: breakpoint: CFI breakpoints only on demand
Reply-To: sashiko-reviews@lists.linux.dev
To: "Linus Walleij" <linusw@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260703-arm32-cfi-bug-v4-1-c26acb640a8f@kernel.org>
References: <20260703-arm32-cfi-bug-v4-1-c26acb640a8f@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 03 Jul 2026 12:48:21 +0000
Message-Id: <20260703124822.130081F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The CFI breakpoint handler incorrectly assumes the BKPT instructio=
n is always 4 bytes long, which corrupts the instruction pointer in Thumb-2=
 mode.
--

commit 8a3d2d7e6aa4575ee54af7475a100d8d6db4f18a
Author: Linus Walleij <linusw@kernel.org>

ARM: breakpoint: CFI breakpoints only on demand
   =20
This removes the stub hw_breakpoint_cfi_handler() from ARM, making
it not steal breakpoint type 0x03 unless CFI is actively used in
the kernel. It falls through to return unhandled fault for userspace
breakpoints.

Closes: https://lore.kernel.org/lkml/kJqktbpLphg_Pk5I5SPptgTLjl3E3eq5mN5UzC=
slyFj7Q1Irp-wDid4mj5eQVd2iZtRGXgeZd8goq195EkXdjyt864YMc8mVb2B9NGH91NQ=3D@pr=
otonmail.com/

> diff --git a/arch/arm/kernel/hw_breakpoint.c b/arch/arm/kernel/hw_breakpo=
int.c
> index cd4b34c96e35e..38feb30dfb5f8 100644
> --- a/arch/arm/kernel/hw_breakpoint.c
> +++ b/arch/arm/kernel/hw_breakpoint.c
> @@ -929,10 +929,6 @@ static void hw_breakpoint_cfi_handler(struct pt_regs=
 *regs)
>  		break;
>  	}
>  }

[Severity: High]
This is a pre-existing issue, but I noticed a potential problem in
hw_breakpoint_cfi_handler() right above this diff.

When a CFI failure triggers a warning (such as when CONFIG_CFI_PERMISSIVE is
enabled), the handler attempts to skip the breaking instruction:

arch/arm/kernel/hw_breakpoint.c:hw_breakpoint_cfi_handler() {
    ...
	case BUG_TRAP_TYPE_WARN:
		/* Skip the breaking instruction */
		instruction_pointer(regs) +=3D 4;
		break;
    ...
}

Does this incorrectly assume the BKPT instruction is always 4 bytes long?

In Thumb-2 mode, BKPT is a 16-bit (2-byte) instruction. If the instruction
pointer is advanced by 4 bytes, wouldn't it skip the intended instruction
and an additional 2 bytes of the following instruction, potentially corrupt=
ing
the execution stream and leading to an Oops?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260703-arm32-cfi-=
bug-v4-1-c26acb640a8f@kernel.org?part=3D1
