Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 276903B52FA;
	Wed,  1 Jul 2026 09:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782898486; cv=none; b=h44QaYfs72J1TEgxzYMav8ZAY1GrLVikmLarsvIDGdIbImy4eLWShhjA2IkfSrsP6H0Ru7Zph80ckoxfdt9alIHL/SYHuwuZI2Od/mECx2Y5YD7lN4yT/z0Nu5PekbUFHxFe7l73q5DJP6UzK3QdI6FIANHuC6C1B6G5/+tdS0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782898486; c=relaxed/simple;
	bh=LomHJHSBbrbrPpJfgrszjuD/iO9ifK+o001M0/h4E24=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cNZCWY+p/CKP0ZlqrTA55i9OorADx+H6dyBpzZs160y7bfTguDVLp9MvCU0QWd1QmcJfwYbQITxf9EJKid5gwbD+H5vBTRkW66brXyGHApbqxi3SeYmIQgxNWJlZe/6A2knmJXgXeqcqijz/EYD92n9zkM4FiREj2RJpogol5C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hmLH5pxe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hmLH5pxe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 817D81F00AC4;
	Wed,  1 Jul 2026 09:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782898484;
	bh=8pToScgcy0iBzj4LPIt1TkgFIE6I0OLg9YG7jH/ubhk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hmLH5pxeRwG01g8EFUoECJCSm/tdr/cjgX3l5jR09+exFyQ1qGAAhF2iDdHnXatX5
	 9GrTneTL2p6mnaWvFHB7/tP1pz38FZTLMMXiRqlplaNhQkeKc3aOEJrJakHhCaxtIH
	 5H6Zl3r2KVOtttLmdZCYSxs0qYOS7T1tZRt2fW9cOHStCf13ELs7+VorQ3qfsmEniD
	 ggcRYc6fghv//LjUNZ6znbLBMZUqsuQBvnkCfoN277j0fSp93+Du+eptk71PYRqq2R
	 yb7xBW+Amx9MlJNl6KVg+7GM9QQlcNbyF38ftur8xusX8ILhB3V+Movb4K7EbsxA+M
	 P8Nc6kZrtOzEg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 22/22] TEST(do-not-upstream): fake qemu vendor JSON +
 mapfile entry for CounterIDMask path
Reply-To: sashiko-reviews@lists.linux.dev
To: "Atish Patra" <atish.patra@linux.dev>
Cc: devicetree@vger.kernel.org, conor+dt@kernel.org, linux-perf-users@vger.kernel.org, robh@kernel.org
In-Reply-To: <20260701-counter_delegation-v8-22-7909f863a645@meta.com>
References: <20260701-counter_delegation-v8-0-7909f863a645@meta.com>
 <20260701-counter_delegation-v8-22-7909f863a645@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 09:34:43 +0000
Message-Id: <20260701093443.817D81F00AC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] This patch contains fake test data and is explicitly marked as '=
do-not-upstream'.
- [Medium] The patch adds a mapfile entry for '0x0-0x2a-0x0' which is not d=
ocumented in the commit message.
--

commit 2c14c47c4b1f0c0aa09f9d1287cb457e27674f5b
Author: Atish Patra <atishp@meta.com>
Subject: TEST(do-not-upstream): fake qemu vendor JSON + mapfile entry for C=
ounterIDMask path

This commit adds fake JSON events and mapfile entries for a QEMU virt
environment to test the CounterIDMask path in jevents.

> diff --git a/tools/perf/pmu-events/arch/riscv/mapfile.csv b/tools/perf/pm=
u-events/arch/riscv/mapfile.csv
> --- a/tools/perf/pmu-events/arch/riscv/mapfile.csv
> +++ b/tools/perf/pmu-events/arch/riscv/mapfile.csv
> @@ -24,3 +24,5 @@
>  0x602-0x3-0x0,v1,openhwgroup/cva6,core
>  0x67e-0x80000000db0000[89]0-0x[[:xdigit:]]+,v1,starfive/dubhe-80,core
>  0x31e-0x8000000000008a45-0x[[:xdigit:]]+,v1,andes/ax45,core
> +0x0-0x0-0x0,v1,qemu/virt,core
> +0x0-0x2a-0x0,v1,qemu/virt,core

[Severity: Medium]
The commit message explicitly states that it adds a mapfile entry for
0x0-0x0-0x0, but it looks like a second entry for 0x0-0x2a-0x0 was also
included here. Should this additional entry be documented in the commit
message, or was it included by mistake?

> diff --git a/tools/perf/pmu-events/arch/riscv/qemu/virt/events.json b/too=
ls/perf/pmu-events/arch/riscv/qemu/virt/events.json
> new file mode 100644
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/riscv/qemu/virt/events.json
> @@ -0,0 +1,26 @@
> +[
> +  {
> +    "EventName": "fake-json-any",

[Severity: Medium]
Since the commit subject explicitly marks this as a test that should not be
upstreamed, and it populates the PMU event list with artificial hardware
events, was this patch included in the series by accident?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701-counter_de=
legation-v8-0-7909f863a645@meta.com?part=3D22
