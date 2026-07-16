Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4470E31E859
	for <linux-perf-users@vger.kernel.org>; Thu, 16 Jul 2026 15:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784215028; cv=none; b=deZoxsRkJz9SDKpEHz2+5qdLYKGYWNl/ZQfg2FZN+4js8ymuv8+PiA8NKCZ3eDAT1+7EpR7Uh5Fkjt1BxanqL602ALUcart/8JDp655GMocovpM1POhkQspihXfUaBcZ516ptd4MygwcRAY7O4+QubYbsSvswbLjBGJMg2csZlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784215028; c=relaxed/simple;
	bh=Hh9HO++01WuYDWaPnMoxpIsBe3GHyFogA+KyJpSmy5o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iKq5LW7/QLB5OqTcg8xzcK1xNqWim6Jb0XMBOwR6bs+In4UUcZjm6RjcyM2gAWWIZxVMqKwXwzK5jkNr6dXGMXpSdrzwbQMl2E9L64yQx1n4UVx710oAT23pRFm9b/yMnKhQjgBB0z6qcvuxWgR52IGnflr7RD+gndWvABfVQRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mjHT1/yN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mjHT1/yN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B13061F000E9;
	Thu, 16 Jul 2026 15:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784215026;
	bh=eioP5YHFdpdEUHZi/v/vAVedxv4Qq+wuMPbcXIOf8u8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mjHT1/yNxC2+ExiHSSvm7DkfSOvvF1VcY6tY45CsyqlDu4DZdyiWf513LsiG9DsXQ
	 cSRJklIEz0YceLMr3qqOz7Xc16mavqIKaU9N4j1vdoBCTIPU5tF8hJatX5tumsDbFK
	 p455brruPw/RUQHSK3raNLwA/tLe7h0cZ33e65iYNarKe4dFGECVOTfX/fJX2KpcWW
	 ThmJBmYEp0UrhqmFZGqAe+eKZItUkV5/5Iz3eLsRDJFaR9sFNDai3aRtaa/q0OPCJA
	 Ug/SyTSRSECbTk55znLpRhHKmpCFlA9eWHP9p4ubjacEjLj3MasbR8dl6hkK/30I7d
	 /+kbPUjVpWs/w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/4] ACPI/APMT: Use stable device ID
Reply-To: sashiko-reviews@lists.linux.dev
To: "Robin Murphy" <robin.murphy@arm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <f7eb9a4cfea4cd6f8d87f3c2501438d484807d27.1784213435.git.robin.murphy@arm.com>
References: <cover.1784213435.git.robin.murphy@arm.com>
 <f7eb9a4cfea4cd6f8d87f3c2501438d484807d27.1784213435.git.robin.murphy@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Jul 2026 15:17:06 +0000
Message-Id: <20260716151706.B13061F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] Platform device ID collision causing APMT parsing abort and subseq=
uent UAF.

Pre-existing issues:
- [High] Missing rollback on failure leaves previously registered platform =
devices holding dangling pointers to an unmapped ACPI table.
- [High] Missing bounds check on `apmt_node->length` allows out-of-bounds m=
emory read.
- [Medium] GSI IRQ mapping is leaked on platform device registration error =
paths.
--

--- Patch [1]: [PATCH v2 1/4] ACPI/APMT: Use stable device ID ---
commit 895c0eb864a4218fbb99620f4fa9efb2dc4e091c
Author: Robin Murphy <robin.murphy@arm.com>

ACPI/APMT: Use stable device ID

The APMT node format includes a unique identifier, so we can use this as
the platform device ID to give userspace stable and identifiable device
names.

> diff --git a/drivers/acpi/arm64/apmt.c b/drivers/acpi/arm64/apmt.c
> index bb010f6164e52..91fcdd289e637 100644
> --- a/drivers/acpi/arm64/apmt.c
> +++ b/drivers/acpi/arm64/apmt.c
> @@ -76,10 +76,12 @@ static int __init apmt_add_platform_device(struct acp=
i_apmt_node *node,
>  					   struct fwnode_handle *fwnode)
>  {
>  	struct platform_device *pdev;
> -	int ret, count;
> +	int ret, count, uid =3D node->id & INT_MAX;
>  	struct resource res[DEV_MAX_RESOURCE_COUNT];
> =20
> -	pdev =3D platform_device_alloc(DEV_NAME, PLATFORM_DEVID_AUTO);
> +	if (uid !=3D node->id)
> +		pr_warn("Unexpectedly large UID 0x%x, truncated to 0x%x\n", node->id, =
uid);
> +	pdev =3D platform_device_alloc(DEV_NAME, uid);

[Severity: High]
Does this newly introduced truncation create a risk of ID collisions if two
unique 32-bit APMT node IDs differ only in the sign bit?

If a collision occurs, platform_device_add() will fail with -EEXIST. This
halts the initialization of all remaining PMU nodes and triggers another is=
sue.

[Severity: High]
This is a pre-existing issue, but when apmt_init_platform_devices() fails
(which is now more likely due to potential ID collisions), the caller unmaps
the ACPI table without a cleanup loop:

drivers/acpi/arm64/apmt.c:acpi_apmt_init() {
    ...
	ret =3D apmt_init_platform_devices();
	if (ret) {
		pr_err("Failed to initialize APMT platform devices, ret: %d\n", ret);
		acpi_put_table(apmt_table);
	}
}

Will this leave any previously successfully registered platform devices hol=
ding
dangling pointers in their platform_data referencing the now unmapped table
memory, leading to a use-after-free when a driver later binds?

[Severity: Medium]
This is a pre-existing issue, but if a device addition fails, does the
cleanup path leak the GSI IRQ mapping?

drivers/acpi/arm64/apmt.c:apmt_init_resources() {
    ...
		irq =3D acpi_register_gsi(NULL, node->ovflw_irq, trigger,
						ACPI_ACTIVE_HIGH);
    ...
}

When apmt_add_platform_device() takes the error path:

drivers/acpi/arm64/apmt.c:apmt_add_platform_device() {
    ...
dev_put:
	platform_device_put(pdev);

	return ret;
}

Should there be an acpi_unregister_gsi() call to reverse the mapping created
during apmt_init_resources()?

[Severity: High]
This is a pre-existing issue, but does the table parsing loop in
apmt_init_platform_devices() need a bounds check on apmt_node->length?

drivers/acpi/arm64/apmt.c:apmt_init_platform_devices() {
    ...
	while (offset < end) {
		apmt_node =3D ACPI_ADD_PTR(struct acpi_apmt_node, apmt,
				 offset);
        ...
		offset +=3D apmt_node->length;
	}
    ...
}

If a malformed ACPI table provides a maliciously small or truncated length,
could this lead to ACPI_ADD_PTR yielding a misaligned pointer and reading
memory outside the mapped ACPI bounds?

>  	if (!pdev)
>  		return -ENOMEM;
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1784213435.gi=
t.robin.murphy@arm.com?part=3D1
