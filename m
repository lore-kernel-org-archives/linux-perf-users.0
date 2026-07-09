Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E74836728B
	for <linux-perf-users@vger.kernel.org>; Thu,  9 Jul 2026 14:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783608758; cv=none; b=teEybnvlOxES6WaZOqzbyDdXM4u8bBmfabI6ORQ+anXoye6KDLLJSSGnxDPDvq4jKQUUEE7gzMLkhvJg4x+JCAJVFX1XZ0UdAVNmhQJF+hnDRjFK5utLqoIQshOLx3c3hAbuZvSlJT7nCtAT57hDbcm6H9ftxlqtUlMbqwNtyRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783608758; c=relaxed/simple;
	bh=tPVvbk0o7ptakcKiiqg1o5WqWP3GKZLv6O2ZcSk1G6E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=V1kJVxM6E/4lVDOJML+dIEu/la/3y+5IgVYuRFl2eXA6GHzhgD1trMZB8joVC3swpMRLJUwZFGX15v+kESn4abG26sL/n3l/jAabf1meAwZ/mbOkzXsKQGc3ePLThyx9hIVvZYq1cN3GPu8x2IDJfhZi/zR2TyTrVll0JGP4J14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TrU6vQwu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TrU6vQwu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAD221F000E9;
	Thu,  9 Jul 2026 14:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783608757;
	bh=PXboZRmuEfb0tjTejkszXSbaDDV5TiMGeT1Uu6JPPgk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TrU6vQwuL876hdD1g3V5K35XAEc5l5xbMaTvyp2fDLJqbzTbER0n8eAccvTCSSiT4
	 aZe4MPLRrm+fJmPVwq2or9MfLNu/mGZ/jdTE/KFiSbHsbXo+h8dwPZVLjbknARo0Kq
	 nzgvYrFdY8lkJXZIiIXSBlMtSZbdDB0Dmg3LeIESnvjNOEK+8EskUD2HrkhgRnvFa6
	 5HueTyALASH3BnNZNbx2uymup4UiIlhNrGLKRvjbxqtksbm9VqOspBhxjMxkXpA6el
	 92N+uC84jNc908eCejevI1VCDJmmFpqM3Z6LMscaJu7ZCxSanI4NEe7tGSaoiA97s9
	 WXG6RzXdinwAg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/4] ACPI/APMT: Use stable device ID
Reply-To: sashiko-reviews@lists.linux.dev
To: "Robin Murphy" <robin.murphy@arm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <c113eff51124250fc5798589ce905052046b43b3.1783605641.git.robin.murphy@arm.com>
References: <cover.1783605641.git.robin.murphy@arm.com>
 <c113eff51124250fc5798589ce905052046b43b3.1783605641.git.robin.murphy@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 14:52:36 +0000
Message-Id: <20260709145236.EAD221F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] Unvalidated u32 ACPI node ID is passed to a signed int parameter, =
causing unintended collisions with platform bus sentinel values and negativ=
e sysfs device names.
- [Medium] Lack of collision handling for firmware-supplied IDs causes comp=
lete APMT initialization failure on duplicate IDs.

Pre-existing issues:
- [High] Failure to cleanly unregister resources and platform devices on er=
ror paths leaks IRQ mappings and creates dangling pointers to unmapped ACPI=
 tables (Use-After-Free).
- [High] Missing structural bounds checking on APMT node length allows infi=
nite loops or out-of-bounds reads.
--

--- Patch [1]: [PATCH 1/4] ACPI/APMT: Use stable device ID ---
commit 5ad772664b7900cfeb996b91d7d0c6ff27d931d6
Author: Robin Murphy <robin.murphy@arm.com>

ACPI/APMT: Use stable device ID

The APMT node format includes a unique identifier, so we can use this as
the platform device ID to give userspace stable and identifiable device
names, rather than auto numbering dependent on how the table is parsed.

> --- a/drivers/acpi/arm64/apmt.c
> +++ b/drivers/acpi/arm64/apmt.c
> @@ -79,7 +79,7 @@ static int __init apmt_add_platform_device(struct acpi_=
apmt_node *node,
>  	int ret, count;
>  	struct resource res[DEV_MAX_RESOURCE_COUNT];
> =20
> -	pdev =3D platform_device_alloc(DEV_NAME, PLATFORM_DEVID_AUTO);
> +	pdev =3D platform_device_alloc(DEV_NAME, node->id);

[Severity: High]
Because node->id is a u32 and platform_device_alloc() takes a signed int
for the id parameter, could this cause unintended collisions?

If the firmware provides a large ID like 0xFFFFFFFE, this would be cast to
-2 (PLATFORM_DEVID_AUTO), which seems to defeat the goal of using stable
identifiers by falling back to auto-numbering.

Similarly, a value of 0xFFFFFFFF would become -1 (PLATFORM_DEVID_NONE),
causing the ID to be omitted from the device name entirely, and other large
values would result in negative sysfs device names.

[Severity: Medium]
By relying on the firmware for the ID rather than auto-numbering, is it
possible for duplicate IDs to cause initialization failures?

If firmware provides two APMT nodes with the same id, platform_device_add()
will return -EEXIST. When this propagates up to apmt_init_platform_devices(=
):

apmt_init_platform_devices() {
    ...
    ret =3D apmt_add_platform_device(apmt_node, fwnode);
    if (ret) {
        acpi_free_fwnode_static(fwnode);
        return ret;
    }
    ...
}

Will this abort the entire APMT initialization and prevent all subsequent
PMUs from being registered?

[Severity: High]
This is a pre-existing issue, but this patch might make it more reachable
if duplicate firmware IDs trigger the error path.

If apmt_add_platform_device() fails, the loop in apmt_init_platform_devices=
()
returns an error without unregistering the platform devices that were alrea=
dy
successfully added during previous iterations.

When this error propagates to acpi_apmt_init(), it unmaps the table:

acpi_apmt_init() {
    ...
    ret =3D apmt_init_platform_devices();
    if (ret) {
        pr_err("Failed to initialize APMT platform devices...\n");
        acpi_put_table(apmt_table);
    }
}

Since the registered platform devices hold a pointer to the ACPI node in th=
eir
platform_data, will unmapping the table leave them with dangling pointers t=
hat
could cause a use-after-free when the arm_cspmu driver probes?

Additionally, the error path inside apmt_add_platform_device() does not app=
ear
to call acpi_unregister_gsi() to clean up the IRQ mapped by
apmt_init_resources(), which might leak the GSI mapping.

[Severity: High]
This is another pre-existing issue, but looking at the table parsing loop in
apmt_init_platform_devices():

apmt_init_platform_devices() {
    ...
    offset +=3D apmt_node->length;
    ...
}

Does the loop inherently trust apmt_node->length without validating it agai=
nst
the structural bounds? If firmware provides a node with a length of 0, could
this result in an infinite loop during early boot?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1783605641.gi=
t.robin.murphy@arm.com?part=3D1
