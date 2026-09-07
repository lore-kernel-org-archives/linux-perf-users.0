Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD09319D8AC;
	Mon,  7 Sep 2026 22:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788819863; cv=none; b=Ma6IyTwpiFNikjaHiMaWqSIwOYMHrL5/ZqPR7uiPI3ErjqUklsILFa7ZqkLw3OIy3s+KorOUvN3xoCWA3Cgx9/hMR3rrz+8go+z0OcrduES3TcPIjvrqZUKEB4GtUeguF2jOlvfsA2UMrinwaaSCkx5nm+rvZIIlVbRo70f7Mqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788819863; c=relaxed/simple;
	bh=Ji4Kvu7LpQqhECYZ1pmgrD7b9aAuvcEK2ZryUdGXyQE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ws3v4V1/o6XCnUhPaBEq7d2KeTw5GkCLSIitkVv+jKN+2oEE79KuYKi4vcolMc82SDNCvowJpWXJiUvgOJUKp5PaN4Ib1yyf2NRuqS7yS6oBr95qX3fQFl7I1WCeOm97dQw8F5/qZZmanVvDRA3Pu5CLkUOTJPij9qwDSdYBqBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jWbFJ4K7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jWbFJ4K7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 315A11F00A3A;
	Mon,  7 Sep 2026 22:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788819861;
	bh=Ji4Kvu7LpQqhECYZ1pmgrD7b9aAuvcEK2ZryUdGXyQE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=jWbFJ4K7m6sh97A0VyTs+bdWzlhd15mB1KnG6i9jInZw/uY1abiISWLt7fsSjdlR4
	 c+hLE3XzZHRZID4X84TFLpkV6hoBCSPsapuzEJW5ZagNAs2Dr7mFdtRQPm1SKixdb2
	 4/d8zwybENmG3Fg4vVcSI4F+qSXousnmwa5RmHnTona09JHTCsCUOlkYPuEq3mlkvk
	 gsp9iCW2nRQZtFr0HEuwZu+WRugX/IsPhcOKwDnvfqWPkq4BSFFi4phfhGFUDiVIJC
	 Kt85rAMfVomYOfvfvr+Sv8B4eeyxzNqHfpD8bO65uQD2CxjXhZD4kdaQgvRSVU6t2c
	 FD7Wv0NCGu11w==
Date: Mon, 7 Sep 2026 23:24:16 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Thomas =?UTF-8?B?V2Vpw59zY2h1aA==?= <linux@weissschuh.net>
Cc: Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>, Thomas
 Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Dave Hansen
 <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin"
 <hpa@zytor.com>, Will Deacon <will@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Yushan Wang <wangyushan12@huawei.com>, Jijie Shao
 <shaojijie@huawei.com>, Khuong Dinh <khuong@os.amperecomputing.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman
 <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, "Christophe
 Leroy (CS GROUP)" <chleroy@kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Danilo Krummrich <dakr@kernel.org>, linux-edac@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-perf-users@vger.kernel.org, linux-cxl@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 driver-core@lists.linux.dev
Subject: Re: [PATCH v2 2/3] drivers: perf: Use __DEVICE_ATTR() macro to
 initialize dev_ext_attribute
Message-ID: <20260907232416.4b0fb386@jic23-huawei>
In-Reply-To: <20260907-sysfs-const-attr-dev_ext_attr-v2-2-bf53afe57071@weissschuh.net>
References: <20260907-sysfs-const-attr-dev_ext_attr-v2-0-bf53afe57071@weissschuh.net>
	<20260907-sysfs-const-attr-dev_ext_attr-v2-2-bf53afe57071@weissschuh.net>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 07 Sep 2026 07:45:02 +0200
Thomas Wei=C3=9Fschuh <linux@weissschuh.net> wrote:

> The upcoming constification of the device_show_*() callback
> signatures requires the users to handle the transition automatically.
>=20
> Switch to the __DEVICE_ATTR() macro which can do this.
>=20
> Signed-off-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>

Acked-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com> #for cxl_pmu
