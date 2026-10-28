Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793231151;
	b=Dtp7zj1bHjobLQOrlE5eIRNZC/ajpjxxWlxhGwkarFem5s5SJSnjqhyTOTUktTOjuo0M
	 YC6HZi4bJ9CsRWg0IUPXaGwRzpyYqqwTRzsUHJNpVgIXwQBP49i6a28/evUkn4qvPIo0E
	 KEn9jRK7OyndPz8df8/24/A/bl7AQZ5q/8k++DRRc8dObqaeQ9Nm1aZk7T9GWo+GUoAO6
	 VQf2Sx+JCBvbAxK/bdjW2EHlvJ7qrM4c6uhGB9tDsBZV70M2J8fXkvHyMxqm3GzZAU/mJ
	 XnrwR6npas7ilHf24DTzDjwCdK4dta+Jo5XC8ewkG1It3AHncGDAtdo8UWSVnUU2+mw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793231151;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=H32krEstWSpdMlKEdfouG5b3drpIJKi0hxf+MEPAf8A=;
	b=Te3ZjCpYWeAtD5QldS8aRoEMhKqhqZ2mwSFWeF4LlcwVMRmZDkG4Gt0pHOrLVXkSqOl4
	 TBKnt1Pu+pIB/A5ntI3G/vIQOOAo+E90ZMx15DGHoOUMiNhI5VKUAUcLwpnK0GIXY6MmL
	 bcn5rC86zy/jCKOXhjBvqd002gynMOPtyPDxYfEUOal43eFTg1CptGDL3GgwcEywp2ryQ
	 b+iZ3gyE+2n+K4W8L2WgO9bsxcTT839M8dX1x3QXp161xpNEmr4hNzRuDJhuZhAnQD+QN
	 /rDOxaVXKsI9QGi98rzEcLy78aaGgqARDzw2P8fY6Zt2z8/ea8P3LrpjCE+NFflKGmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PuYP9soc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF00606A31A
	for <linux-perf-users@vger.kernel.org>; Wed, 28 Oct 2026 23:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PuYP9soc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 396B81F01825;
	Wed, 28 Oct 2026 23:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793231150;
	bh=H32krEstWSpdMlKEdfouG5b3drpIJKi0hxf+MEPAf8A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PuYP9socLkSQQj/3YHYeQ4mqdtqDLFvoOERESaU8SfaXOtkgCDYO8/6sKqg2Z4Kra
	 50FSLCyrHSm7dJgCOokAW87+zuL2pGkK88/ACQOVbvqElBkJqNMJ9mGj6INFsde8TH
	 YxqbaQd+QXYDsuES0k+hk2yYjRDA7igMxYBJL7dPEqD+PFkUFuL3TsdpMFACsUEZ0C
	 8DF4lNkQ4MBwfZOId+/sD24Fv8Hqm3GX3fQt8VrSoQToCN7R5P7dP29OebJDJ4BEEa
	 JRO0fAs8qinTcymdCz27622YoK3ko4uq23YEodsCe7B1ejQMK9FNmq+8HK6UDpf21o
	 bgZl/m2IFCBNw==
Message-ID: <sashiko-outbox-188549@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 2/5] perf symbols: Split out name-independent
 duplicate symbol selection
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alireza Haghdoost" <haghdoost@uber.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261028-perf-symbol-memory-send-v6-2-7e90415f0101@uber.com>
References: <20261028-perf-symbol-memory-send-v6-0-7e90415f0101@uber.com>
 <20261028-perf-symbol-memory-send-v6-2-7e90415f0101@uber.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 23:45:49 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> From: Alireza Haghdoost <haghdoost@uber.com>
>=20
> This patch is a refactoring and does not change behavior. It moves the
> size, type and binding checks from choose_best_symbol() to
> choose_best_symbol_by_attrs(). It also adds symbol__choice_needs_names()
> to report whether choosing between two symbols requires their names.
>=20
> symbols__fixup_duplicate() keeps one of the symbols that share a start
> address. It compares size, type and binding first. If those attributes
> are equal, it compares leading underscores, name lengths and the result
> of arch__choose_best_symbol().
>=20
> An unresolved lazy symbol stores a file offset instead of a name
> pointer. Thus, the lazy loader cannot call choose_best_symbol() until it
> loads both names. The new helper lets the loader keep the names
> unresolved when the attributes select a winner. It loads names only when
> the attributes are equal and duplicate selection needs them.
>=20
> Signed-off-by: Alireza Haghdoost <haghdoost@uber.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261028-perf-symbo=
l-memory-send-v6-0-7e90415f0101@uber.com?part=3D2

