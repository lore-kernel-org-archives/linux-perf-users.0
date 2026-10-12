Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C62B361675
	for <linux-perf-users@vger.kernel.org>; Mon, 12 Oct 2026 07:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791791948; cv=none; b=JSy6MFj2SJSsZrpd02wJqa1SjJHTweEu9cwUWU175c0KA9+CTkG04KWs15/DYs/u/pZUu2ew1Jkqyt7q72TdMzjSdMIH41vAV030BPzoyL3VJP+Butk32Cc6EudEQPwB/qSeZBSXMp+cWhZaiOhue/c01WRk0N5wKNN30lTqxgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791791948; c=relaxed/simple;
	bh=/rmTPCiR2W3sBp9oiH8evRMzpeHkdPNAz04XSBXvyTI=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=aMQnZb78dMQ7wQVBhviuIB8FP10Rtys7q/GNt7IVFMydPICBgvphN8oYSQlg4TeP8oUdZT/H5LtRk0ruiN4Mu8d6S7trU1J4dCW5kpiPS4K4HzZke3uFiz018Ol5jrzgctfK/h7XY4bOaJFGSncf3aMnckNcX98G0D7cSge5bSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RoVy4NaD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RoVy4NaD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B1451F0089C;
	Mon, 12 Oct 2026 07:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791791946;
	bh=/rmTPCiR2W3sBp9oiH8evRMzpeHkdPNAz04XSBXvyTI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RoVy4NaD3G51yqINwHGq+s5FUJ32oQGifJGMvRpkmCHVS+IRaDqzlTcRZLcccfF7Z
	 qmCViMPO9EQiRt1hFeMT8xfQWE+6LCplyrRyUPFaL9du6mz6Lygjx8PKcbTbVPDx0q
	 MS5mFhGJ5/uoJ+nNZh3mdX2Dr2Mr5T8LaSgoxxwrW3Of1Ro6q49mz1KGAv3QMBNeOR
	 JFD1pIthq9bAuv8+nkj2kvzmadKY2b+OMVWnNiJCAtIRtlv2+uljIJ5+6rlvsa4Ny1
	 ZwrqmwRFfWwMG3UDOZfgBsUKr7v0ueGajClabzDHB57Rh3htHQzJGIDfqU1RaufkZ0
	 gzTo+NtyNb1kw==
Message-ID: <sashiko-outbox-167816@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] perf vendor events amd: Add Zen 6 data fabric
 events
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sandipan Das" <sandipan.das@amd.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <9ae74ab1337b627f06f1cfb9e5c91c6e42ac6284.1791791463.git.sandipan.das@amd.com>
References: <cover.1791791463.git.sandipan.das@amd.com>
 <9ae74ab1337b627f06f1cfb9e5c91c6e42ac6284.1791791463.git.sandipan.das@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 07:59:06 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Add Zen 6 data fabric events sourced from Section 8.1 titled "Fabric
> Performance Monitor Counter (PMC) Events" of the Processor Programming
> Reference (PPR) for AMD Family 1Ah Model 51h Revision B0 processors,
> available at the link below.
>=20
> The events are primarily meant to monitor the flow of data at various
> links and interfaces within the Data Fabric.
>=20
> Unlike previous generations, the events do not set "PerPkg". On Zen 6
> processors, a socket can have up to two IODs, each with its own Data
> Fabric instance. Perf de-duplicates "PerPkg" counts by socket and die,
> but the two IODs do not show up as separate domains in the topology
> information. Setting "PerPkg" would therefore drop the counts from the
> second IOD. The trade-off is that counts are no longer de-duplicated if
> a CPU list with multiple CPUs from the same IOD is specified with "-C".
>=20
> Link: https://bugzilla.kernel.org/attachment.cgi?id=3D311021
> Signed-off-by: Sandipan Das <sandipan.das@amd.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1791791463.gi=
t.sandipan.das@amd.com?part=3D1

