Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5835A3749F5;
	Sat,  3 Oct 2026 01:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790991207; cv=none; b=EZms0rtLhJ/yH7SNLdS5Eu70/nymK7b7eVnvLbG+6cw7Iq0k+T7CK889xyOa2oNlhqaRVPs7D6naMu1jt7bdx/Vpd+w8B8D1Gm4bDSkjiU1chDsl4XkbY6X0AE5rcja5QvcVPY7aL7yQ7I+zKVz0CfN67pky9Bd3Ptdn3qg5Zgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790991207; c=relaxed/simple;
	bh=23JWH69aa0okR4v2H+xeaTTJm6s6amR+Ox8KhGo/qaE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lUXWnbERmHtIqYVsyjWTCaJS3S6fdlZzXwoHmygoj3D6IPeSS1i6zmQFfM9ERk+caXi+EbismWJQoaNsRdtQwiSzCXBRCQCDzm62+TrSF3rRxnVyXQ9qbQaj9/48HUR8hI8XHZEFwEoNSmDyseVCFlzs2+0WDZDMmoS3zIMyDzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oeg50B2+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oeg50B2+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E713E1F000FF;
	Sat,  3 Oct 2026 01:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790991206;
	bh=23JWH69aa0okR4v2H+xeaTTJm6s6amR+Ox8KhGo/qaE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Oeg50B2+wi3EMqJZYl+mVSfvJFKJloOyF5rIJbwPP7lfjZi/2nVsJ1PfVJDVQwqTU
	 z4W1AEEMbf98kk2R6O9XotjDGJMlpUNcsTAuRFHuYpl0hqYsSUFLIZzvHakJKYkeeT
	 Pi4w/vgQVuafwVXycngkGm2lVt72oCp3JuTAOKqke0ry/oHe054Y6wkiaAcLRANK1N
	 BxeZfI78G5U/T6rOKM6V24T+wLRjagfCEgWfkp/s5a39z8d8rsmMqNwybhYsbDzmue
	 uxKPAIBtPgqTQIBGg3hkBnpCgzL6H9U5kjpkT3f0bi6mDXkPh4BGyk7dx8azaPNCTP
	 1Pe+0RJx4X/Bw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v14 1/3] dt-bindings: perf: Add Broadcom Raspberry Pi
 AXI PMU definition
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: devicetree@vger.kernel.org, conor+dt@kernel.org, linux-perf-users@vger.kernel.org, robh@kernel.org
In-Reply-To: <20261002175738.3242646-2-irogers@google.com>
References: <20261002175738.3242646-1-irogers@google.com>
 <20261002175738.3242646-2-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 03 Oct 2026 01:33:25 +0000
Message-Id: <20261003013325.E713E1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Add device tree bindings for the Broadcom Raspberry Pi AXI PMU block
> found on BCM2835, BCM2711, and BCM2712 SoCs.
>=20
> Depending on the SoC and security configuration, these PMUs support
> either direct MMIO access for the System monitor or routing via the
> Raspberry Pi firmware mailbox IPC for the VideoCore VPU monitor.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261002175738.3242=
646-1-irogers@google.com?part=3D1

