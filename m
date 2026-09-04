Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A7C4F55A0
	for <linux-perf-users@vger.kernel.org>; Fri,  4 Sep 2026 15:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788534129; cv=none; b=T0lTfHO0mT5fFDR1N7pSn7KBlRxsuj3Bbf14oCHdcZjNcWhpcG6whzb1/Nim/DgwIPmmcwT8AcHA/8i7Ar1hwkA0SYPfzDeB5IYI7YD/P4bzkI8byNnoorvMG4oPD/cjW7o9DT77EBj+rhRCLtVoWbE07DCn9K572RMNHvBRxcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788534129; c=relaxed/simple;
	bh=5j/YAe3BEXx7/1RcBirAPoFTByGPGd4l0qj0gp9Pi74=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=q4ENAlb5i8gGdnyvpHFsicyzhEEY/G1Uou4YBMtovGVPWnBgdh61I/ilIb+SaN188ACmxwyvjSUuvjjDVeZ0ACjYecjiH5BZ4AE3mLZUzPvdp8mL44nph2hXJszfhAnyrqzHxTEhbdkQy0p7jR5AahQ2voBw0gB7ztoODx/yC7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GfdsVNAJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GfdsVNAJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EBC71F00A3F;
	Fri,  4 Sep 2026 15:02:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788534126;
	bh=bJeq6sLvfuxf5NgE4JXm7ZTTYs/Qm23o/IiNSOD0MSE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GfdsVNAJRwATIx2/oH8b8hhcaNffyl0OwLOqdcrJzT6h902cah/K8CQh6FacklzCi
	 KLX+NO2iyI3uVOjhFy/kxOhYXvRWhL0W/2N5Mw3o86FurUg/OSn2OyJGMtTklSyxjZ
	 +EkoqAqsMLlHR5AVzRzrahtLu8k9aTEW3ELUc5gMxXBZ0NJvZPFukAnoWGSuiMq8Hn
	 TwzybVLqFxb9p8ZdtIOCBX1JahojhLdICGallMMJ5Cbxpqgk/ohhIyP4VI4SJr1JhN
	 jVrYKSFFgC1B91M2FWbopiAPlwieCSOldduVl7k6k6Vj2+xjvKCeciSwIBcoa9kzp/
	 iSCs/bjr0pm8Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/5] perf genelf: Use unaligned-safe accessors for debug
 entries
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260904144058.3341-3-acme@kernel.org>
References: <20260904144058.3341-1-acme@kernel.org>
 <20260904144058.3341-3-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 15:02:05 +0000
Message-Id: <20260904150206.3EBC71F00A3F@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> debug_entry records are packed with a variable-length name[] field, so
> entries after the first may start at addresses that are not naturally
> aligned.  jit_process_debug_info(), get_special_opcode() and
> emit_lineno_info() read and write the u64 addr and int lineno fields
> through struct member access, which is undefined behavior on
> strict-alignment architectures.
>=20
> Use get_unaligned()/put_unaligned() to read and update each field,
> matching the layout the jitdump writers (LLVM, JVM agents) emit, which
> packs entries without padding.
>=20
> struct debug_entry.lineno is signed and emit_advance_lineno() takes a
> long line delta that relies on sign extension, so the field is read
> into an int: reading it into an unsigned int would turn a backward
> line jump into a huge forward one and corrupt the line number program.
>=20
> Reported-by: sashiko-bot <sashiko-bot@kernel.org>
> Cc: Stephane Eranian <eranian@google.com>
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904144058.3341=
-1-acme@kernel.org?part=3D2

