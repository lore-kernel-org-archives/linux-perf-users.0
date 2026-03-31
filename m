Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739F43E0C7C
	for <linux-perf-users@vger.kernel.org>; Tue, 31 Mar 2026 12:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774959880; cv=none; b=Uc6MFX9F8ZSwbbhOtwRgbsWoQRLJzy4WS/pOWLom0taGg836+y23xaKDYtyvPuqd4lNK+FdjdXepNICDZ7SP+HEg06I1RdcBjdrhYQI6d+vURpPnS1lvo2cpK38M7eKRrOptCtShG5p8qBupJ0HLPw70bJ2fW+dQ69Doo5bzHlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774959880; c=relaxed/simple;
	bh=+v0lsG31lmz9yOKp4sThWdLD00iDG9mSDxn4BdCze+s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r7nFIa/BlFwGuy/BkleI2ZF6lIeEeFktIHX0sqB6RSTzSJlzvIE5JcnPvIPY/rY4Q73lICKZrhRivy+x2v0snXj8tx//Ltx1Y00xH1LNu8IdGZNZoso4XeQMb/YjFMzUFfExjyVYP0iYGhIiPqxskA7hCXtD6NtnC8uMcfVfJkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RJZmO7Tv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RJZmO7Tv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 589BEC2BCB4
	for <linux-perf-users@vger.kernel.org>; Tue, 31 Mar 2026 12:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774959880;
	bh=+v0lsG31lmz9yOKp4sThWdLD00iDG9mSDxn4BdCze+s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=RJZmO7TvhY88kQe3eU7xRIwnSJdkZvyh60WN8MrF2rST5eqYT7Si7twWZg/DT2ZoX
	 YzqUgPxfYDwdo0IEdVVzbGnpMkc2xEIEQWtZG/kOBKnlwvP5OBf9k5ABA9qJOS+Ukj
	 eOekVrlTQVDRLMnCElfoE+fONsncPPw1jhKXxukkxEyJi7dEXS+heu/pZUzPng526Q
	 fQrEJ4DiG53+M4yOJk7Zh135J6HBPJuwoHDZrzQcHd3EDgZteWUMcAVKR5sOaepyV5
	 f2xbf4yCO62QwUTSWKNB376JIzJj0sbMnh6R7hTd0WRb04t6xyHnCnYuuXajw89d5X
	 Ti2a3xJRDsK2w==
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-4152698e745so2024693fac.1
        for <linux-perf-users@vger.kernel.org>; Tue, 31 Mar 2026 05:24:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXa2Z2rHXBqjYPy55QA/UzuFhIsKGxaXpQhmQNW/m3sNgYZSlYGrNdbM78jQDmTYN1TOBL9XLsB9Y0mpGL8eXS8@vger.kernel.org
X-Gm-Message-State: AOJu0YwyadEW4dVg+DMe3TXQV2XUkPUlS93w9+UqYj/CIXg+L2ekB7/7
	n+pAhMBvnwGtV0jiZcbTVdJdNmfAnCMaapTWwSHY1/jiMXFjaK1TlCXE1qO7xv5rQwGDPN6XWZL
	2Z0+HcLGVpTm0ad1/xlKXRyxn04ymOB8=
X-Received: by 2002:a05:6870:3212:b0:41c:5212:2c7e with SMTP id
 586e51a60fabf-41cec149624mr8736242fac.20.1774959878527; Tue, 31 Mar 2026
 05:24:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260320031737.35048-1-fengchengwen@huawei.com>
In-Reply-To: <20260320031737.35048-1-fengchengwen@huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 31 Mar 2026 14:24:26 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gO1VSPs58JeupaiTZBkP3i_-H2bEQpfU-6k2TXjdiaOQ@mail.gmail.com>
X-Gm-Features: AQROBzDL-JtY7QC0BpuyBPGCuLquO5-Gf9GrQy5Yvy_4yGsymDKEHbc8tb9l0x0
Message-ID: <CAJZ5v0gO1VSPs58JeupaiTZBkP3i_-H2bEQpfU-6k2TXjdiaOQ@mail.gmail.com>
Subject: Re: [PATCH v10 0/8] ACPI: Unify CPU UID interface and fix ARM64 TPH
 steer-tag issue
To: Chengwen Feng <fengchengwen@huawei.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>, Juergen Gross <jgross@suse.com>, 
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, Sunil V L <sunilvl@ventanamicro.com>, 
	Mark Rutland <mark.rutland@arm.com>, Jonathan Cameron <jonathan.cameron@huawei.com>, 
	Kees Cook <kees@kernel.org>, Yanteng Si <si.yanteng@linux.dev>, 
	Sean Christopherson <seanjc@google.com>, Kai Huang <kai.huang@intel.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Thomas Huth <thuth@redhat.com>, 
	Thorsten Blum <thorsten.blum@linux.dev>, Kevin Loughlin <kevinloughlin@google.com>, 
	Zheyun Shen <szy0127@sjtu.edu.cn>, Peter Zijlstra <peterz@infradead.org>, 
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Xin Li <xin@zytor.com>, 
	"Ahmed S . Darwish" <darwi@linutronix.de>, Sohil Mehta <sohil.mehta@intel.com>, 
	Ilkka Koskinen <ilkka@os.amperecomputing.com>, Robin Murphy <robin.murphy@arm.com>, 
	James Clark <james.clark@linaro.org>, Besar Wicaksono <bwicaksono@nvidia.com>, 
	Ma Ke <make24@iscas.ac.cn>, Wei Huang <wei.huang2@amd.com>, 
	Andy Gospodarek <andrew.gospodarek@broadcom.com>, Somnath Kotur <somnath.kotur@broadcom.com>, 
	punit.agrawal@oss.qualcomm.com, guohanjun@huawei.com, suzuki.poulose@arm.com, 
	ryan.roberts@arm.com, chenl311@chinatelecom.cn, masahiroy@kernel.org, 
	wangyuquan1236@phytium.com.cn, anshuman.khandual@arm.com, 
	heinrich.schuchardt@canonical.com, Eric.VanTassell@amd.com, 
	wangzhou1@hisilicon.com, wanghuiqiang@huawei.com, liuyonglong@huawei.com, 
	linux-pci@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	loongarch@lists.linux.dev, linux-riscv@lists.infradead.org, 
	xen-devel@lists.xenproject.org, linux-acpi@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 20, 2026 at 4:17=E2=80=AFAM Chengwen Feng <fengchengwen@huawei.=
com> wrote:
>
> This patchset unifies ACPI Processor UID retrieval across
> arm64/loongarch/riscv/x86 via acpi_get_cpu_uid() (with input validation)
> and fixes ARM64 CPU steer-tag retrieval failure in PCI/TPH:
>
> 1-4: Add acpi_get_cpu_uid() for arm64/loongarch/riscv/x86 (update
>      respective users)
> 5: Centralize acpi_get_cpu_uid() declaration in include/linux/acpi.h
> 6: Clean up perf/arm_cspmu
> 7: Clean up ACPI/PPTT and remove unused get_acpi_id_for_cpu()
> 8: Pass ACPI Processor UID to Cache Locality _DSM
>
> The interface refactor ensures consistent CPU UID retrieval across
> architectures (no functional changes for valid inputs) and provides the
> unified interface required for the ARM64 TPH fix.
>
> ---
> Changes in v10:
> - Refine commit header&log according to Punit's and Bjorn's review
> - Split perf/arm_cspmu as a separate commit which address Punit's
>   review
>
> Changes in v9:
> - Address Bjorn's review: split commits to each platform so that make
>   them easy to review
>
> Changes in v8:
> - Moving arm64's get_cpu_for_acpi_id() to kernel/acpi.c which address
>   Jeremy's review
>
> Chengwen Feng (8):
>   arm64: acpi: Add acpi_get_cpu_uid() for unified ACPI CPU UID retrieval
>   LoongArch: Add acpi_get_cpu_uid() for unified ACPI CPU UID retrieval
>   RISC-V: ACPI: Add acpi_get_cpu_uid() for unified ACPI CPU UID
>     retrieval
>   x86/acpi: Add acpi_get_cpu_uid() for unified ACPI CPU UID retrieval
>   ACPI: Centralize acpi_get_cpu_uid() declaration in
>     include/linux/acpi.h
>   perf: arm_cspmu: Switch to acpi_get_cpu_uid() from
>     get_acpi_id_for_cpu()
>   ACPI: PPTT: Use acpi_get_cpu_uid() and remove get_acpi_id_for_cpu()
>   PCI/TPH: Pass ACPI Processor UID to Cache Locality _DSM
>
>  Documentation/PCI/tph.rst          |  4 +--
>  arch/arm64/include/asm/acpi.h      | 17 +---------
>  arch/arm64/kernel/acpi.c           | 30 ++++++++++++++++++
>  arch/loongarch/include/asm/acpi.h  |  5 ---
>  arch/loongarch/kernel/acpi.c       |  9 ++++++
>  arch/riscv/include/asm/acpi.h      |  4 ---
>  arch/riscv/kernel/acpi.c           | 16 ++++++++++
>  arch/riscv/kernel/acpi_numa.c      |  9 ++++--
>  arch/x86/include/asm/cpu.h         |  1 -
>  arch/x86/include/asm/smp.h         |  1 -
>  arch/x86/kernel/acpi/boot.c        | 20 ++++++++++++
>  arch/x86/xen/enlighten_hvm.c       |  5 +--
>  drivers/acpi/pptt.c                | 50 ++++++++++++++++++++++--------
>  drivers/acpi/riscv/rhct.c          |  7 ++++-
>  drivers/pci/tph.c                  | 16 +++++++---
>  drivers/perf/arm_cspmu/arm_cspmu.c |  6 ++--
>  include/linux/acpi.h               | 11 +++++++
>  include/linux/pci-tph.h            |  4 +--
>  18 files changed, 158 insertions(+), 57 deletions(-)
>
> --

It doesn't look like anyone has a particular heartburn related to this
series, so I could apply it in principle, but I'd appreciate some ACKs
from arch maintainers.

Why don't you resend it with all of the tags collected so far (and
please add x86@kernel.org to the CC list)?
