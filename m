Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794973593;
	b=QN5CHocI5/ed6UWFWFTJ3hobhy417NUjyYkDsOWS9UxxEBDvmDle14/YiIcf/vCw69FN
	 CHsQRzWqvJpl9KZNFSPv4/W3JToxdZ66onIgr9GqRVL+gHFYtAqIGuLD3kBsQurfQq+i1
	 P/Tn3u5uv5r46kVw2sOOZctqlMDEiF09IG0Rmo27fkshQ0jK5wkrbW1ewPBJouPv0Q6e7
	 dw1BXKMVh5vFlZ7YS3FKS9P37UTwXrOV4DizGl01legI8cgfYwnexSeR/QcHWOmpM9kgD
	 yTkuRGbwu1S/tknSdHLVFmXsxf6Otoekz49TaoxggjTBtqM2kwj8/ENX30XXtJZo3BQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794973593;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ab9nVsltaFZp30BNEzwkA+hDy+p56zTEwMTDDMOJdFo=;
	b=l+JlvNjSBaRZOtvcIBLGxlAOUusmHqmrl1lO3c+9g7lpkFjRnLf06Jzqbay7NxldTHEA
	 aXRi0HrF1fIlF7lhNhJvmrXpl4j2k/I+GCw1sBvnwj9lYf/hSXzgHp68WvfvtsBHuxn07
	 GPZ0ybbf/d9/1utsGtV7s0vzIHXol4LxD/D5diFp0sIAkLmdHWt0SHT6XEcpBCltdbLkt
	 tRTDTp4CPZ/+aci/pI58k3TmTA9eb30Ad2bzFoozlsFqWaIIcueDgjdLcvyHrdsz1ZGzO
	 iheTPjsNOl66A8J/X7RF3Ni7Wm01ltKBUfv3Eov2UGMWFm7tqytml1YwXmNk4vg5RiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PEiR5DJ9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61035606A325
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Nov 2026 03:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PEiR5DJ9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D09201F000C4;
	Wed, 18 Nov 2026 03:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794973593;
	bh=ab9nVsltaFZp30BNEzwkA+hDy+p56zTEwMTDDMOJdFo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PEiR5DJ9HOfjZiGC2JoWdXtrX+SdORO6+M3nOpNgh97cmwetfESnag4oXJlh5Lz5I
	 I3BiokJtob6JgaCigriPRcHvsNSRI0SprbpI7i0HNe+wpuFPfaWh1IytmKDgTDEbY+
	 /xSA81ZIlslRF3WaFUtqNBcGFKlmRkqxh+/wg9NKZlraOPODGyYpqYWgXmiMKhQieT
	 1OGfrBSqq0sGfZt65z/iHPdTJojxlfnY2CPBZUqf4+syAwF02yIB2O4xSvVr51WOpd
	 CD62njNJgJ4wlBvMKaYN+s8uf2Ng3pzTHoHjije56a9lJ1ysjgibzl+m51oHFpdCW3
	 lhuZ4uqWbQrgg==
Message-ID: <sashiko-outbox-220041@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [Patch v7 13/24] perf/x86/intel: Always snapshot live hardware
 LBR state for BPF
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261118031453.1353625-14-dapeng1.mi@linux.intel.com>
References: <20261118031453.1353625-1-dapeng1.mi@linux.intel.com>
 <20261118031453.1353625-14-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 03:46:32 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> __intel_pmu_snapshot_branch_stack() is intended to capture the current
> live hardware LBR state for the BPF path. However, that snapshot is
> currently skipped when all LBR users are PEBS events.
>=20
> BPF LBR snapshotting now uses its own dedicated LBR stack, so there is
> no longer a risk of clobbering the shared default LBR stack. Move the
> lbr_pebs_users check into the PMI handler, which is the only caller that
> relies on it, so the BPF path always snapshots the live hardware LBR
> state.
>=20
> Fixes: c22ac2a3d4bd ("perf: Enable branch record for software events")
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118031453.1353=
625-1-dapeng1.mi@linux.intel.com?part=3D13

