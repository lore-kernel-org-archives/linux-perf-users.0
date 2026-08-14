Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF0F1296BC8
	for <linux-perf-users@vger.kernel.org>; Fri, 14 Aug 2026 01:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786670577; cv=none; b=hXHcwtZEa5IEOEWTG9GlR6rJvjgtUlcpM3kYxipeOFws5aGlEihBG93BOMJCviLvZG8fdf2ES9YJ1O/uPPW8q0Sw/Fbqyou7pxNk9La0hFgu+S7xOPxeihlIDadKGXQha3qIYzOC3tFKqZYxMPS73grl8Q8Wvv2UplXwwQD0OFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786670577; c=relaxed/simple;
	bh=Rs/11SPEITdDwtTaiyfjh7gv4PihcNkZn/KVmHKkkEg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tnvOxZ7GAxgqHSIWX9xHvaYgPZj5WA4VpWF/MWVzzrwGptBHZRNmjixO4NiI2nS/0Axf3BGQMtQXni+7f8+CEXo0BMG9Z7ytIwN/N9AbVMXYO+0dBHduWbtEFDIqTJl2mst8iRIBNbK5iH/ucbNpWh0nbEmaeoO3mPk/0moe1dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q8SRjQ2o; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q8SRjQ2o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3111B1F000E9;
	Fri, 14 Aug 2026 01:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786670576;
	bh=Rs/11SPEITdDwtTaiyfjh7gv4PihcNkZn/KVmHKkkEg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Q8SRjQ2oCa5i+QbuiI5pzTjtjsXEMZC3BDGPDBQAIrk6GTXW38VkdlcZvJ42CLaR+
	 vLHT68MWYfVwDHLffcFlk5eTEbrnyrWuTVQzQbcFQ5y65fLeehzUmlOZyXeyH680NE
	 dIFZwz/b8ID1o7Pg8hUBPY0Opsx3QvLXFeSBY6YVpCzOXH6RPTlQE/xXW0/VLqbjd9
	 PUE6SiDYIQ4QIBoJ7uiaGIYiIXGl9eDxc4db9vx2SGgTnRRARawJmBpMNW4drmOf5e
	 NMb/Ol5QShciFozc4VHOx85yDBapgky03bKZ8rTA18uDDpQvJx18qX+oo7fHG4ckJ6
	 KeR4AoouPPxJQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/4] perf tools record: Modernize -W man page
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andi Kleen" <ak@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260813214143.253418-2-ak@linux.intel.com>
References: <20260813214143.253418-1-ak@linux.intel.com>
 <20260813214143.253418-2-ak@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 01:22:55 +0000
Message-Id: <20260814012256.3111B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Modernize the -W / --weight description in the manpage to cover more
> cases that are supported now.
>=20
> Signed-off-by: Andi Kleen <ak@linux.intel.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813214143.2534=
18-1-ak@linux.intel.com?part=3D1

