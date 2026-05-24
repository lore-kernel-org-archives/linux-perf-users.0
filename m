Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A692571DA
	for <linux-perf-users@vger.kernel.org>; Sun, 24 May 2026 04:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779595534; cv=none; b=nuk5lHSeXDbsMcAKhXfnmKVV6svvtyl344Zt/H618QoMPP5hDr1VkEWEq4kRPqu+p0WuaPL/j5fvqyZqGHEkfsrskJ4nTfTXYxhesLvhEXlWEZU64fqkp1YjZbCHSWZafnvMn232M5j3HnEnurGxRTGIM4yxNTRiYJo1wZkKO6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779595534; c=relaxed/simple;
	bh=j2T65UrEnJ/NYmQdXsMok/5WUNOEYTBejBl/wf2N3w0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rV6XcysMqSmRuuFFA2WMUqnaO+/V/YCYjaccxmYh7kDQATPfxhi43XMHRbhZO1BoXxgUsDie5JTwH6wBbq0zFlxrRGq1v/hWPsLzh3Kb32HIWoxI1RdO/85GE4QU7L5DNa2E4FFCFT+kEaVahyWxsn9dvbOo30+NrG+ngU/2pW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cg8oQNfg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cg8oQNfg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 522BF1F000E9;
	Sun, 24 May 2026 04:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779595533;
	bh=j2T65UrEnJ/NYmQdXsMok/5WUNOEYTBejBl/wf2N3w0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Cg8oQNfg8423oEd+bO33o3aXQM0ope9oXmoMng/Akt+8vbwcXkgzbZ3nXSnM2ZCUK
	 pMzTpIRs56rvCoY78JJnHwNRsi1B3pd3F5PZjqMhhMwGL8GVo7bdg9yS6P3sNaZQTx
	 fGmJLL90nxPG4q09fhX/2Jr7Eh8oeFC93C2x+0mb52eDjJXrm+vg6ENiVvdJbDYsSO
	 TFh7dBhN/fj3DKYcl4WYoOdU3Xzg9MiZSCBItDancnMRhuS2R/WzZgnaLQc5RxkAdA
	 k02b+Xf2hcO8RKjvKEUETynXcpXRbrNMxHJG5UAr6Fq75hEorwX1loOWuS82qHVbpr
	 FnCVar7xAlGPA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 08/29] perf session: Add validated swap infrastructure
 with null-termination checks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260524032709.1080771-9-acme@kernel.org>
References: <20260524032709.1080771-9-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 24 May 2026 04:05:32 +0000
Message-Id: <20260524040533.522BF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [Medium] The swap handler for PERF_RECORD_STAT_CONFIG calculates the byte=
 size incorrectly, leaving the last 64-bit value unswapped.
- [Medium] Remaining `deferred_samples` are leaked if sample parsing or del=
ivery fails during `session__flush_deferred_samples`.
- [Medium] Integer overflow in `perf_session__peek_events` allows an infini=
te loop via crafted `auxtrace.size`.
--

(Note: The format of this review has been altered to provide a free-form
summary of the findings without directly quoting the patch, in order to
comply with recitation restrictions.)

commit 37f83323fcf820defdbb6fa04353de5f871f8615
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf session: Add validated swap infrastructure with null-termination checks

This commit changes swap callbacks to return an int instead of void to
allow error propagation, adding null-termination checks for several string
event fields.

[Severity: Medium]
This is a pre-existing issue, but I noticed something unusual in the size
calculation for perf_event__stat_config_swap(). When calculating the size
passed to mem_bswap_64(), the code does size +=3D 1 to account for the nr
item itself. However, since mem_bswap_64() expects a byte count and swaps
8-byte chunks, adding just 1 byte results in (16 * nr + 1) total bytes.

Does this cause the function to swap only 2 * nr elements, skipping the
final 64-bit value of the payload on cross-endian machines?

[Severity: Medium]
This is a pre-existing issue, but looking at
session__flush_deferred_samples(), if evlist__parse_sample() or
evlist__deliver_sample() fails, the loop terminates immediately via a
break statement.

Are the remaining items in the evlist->deferred_samples list leaked in
this scenario, since they are not unlinked or freed during an early error
return?

[Severity: Medium]
This is a pre-existing issue, but I have a question about how the offset
is advanced in perf_session__peek_events() for AUXTRACE events. The offset
is incremented by event->auxtrace.size, which is read directly from the
file.

If an excessively large value is provided, could this cause an integer
overflow that wraps around? If offset wraps, could this bypass the
offset < max_offset loop condition and result in an infinite loop when
parsing a malformed perf.data file?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260524032709.1080=
771-1-acme@kernel.org?part=3D8
