Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A95519E09
	for <linux-perf-users@vger.kernel.org>; Fri, 16 Oct 2026 17:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792172614; cv=none; b=Cd5adA7M0/4l12gAhVVfnA0ugBAQK3ar2x1N80CGq5+z4bh+MT5iHJjrDCBP8ECZChVB12jHGvq1C/rx2wuXBiSpxuSUyccWPDZVNImvnXk3amsIaSMPimFTXPFPYmDQ2nHm6nJC7Jhv6+KoROAQ4aUMTfGAVB051sgTtITrcwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792172614; c=relaxed/simple;
	bh=XbjeMvsfjZcO7fDbpWyMlQYg2ufn1nMRaJ6hnZhoorA=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=t7x12ILIgyyzdRTeLSOteKeblOvCFxayuH1B2dla7coTCHpqBJvWq7OcVUyy8H/WPxGJr4Bex42G+En7sZdoUCHPr7BciDQT5dtYaf5PCaRdkHEr7OxrpxJd/OaWR82o9Y9kvMBuZk5A2a5NgXXe2sfYWmA2SIqbzjEUApnkTQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UcJC1cmU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UcJC1cmU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB6CC1F000C5;
	Fri, 16 Oct 2026 17:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792172613;
	bh=XbjeMvsfjZcO7fDbpWyMlQYg2ufn1nMRaJ6hnZhoorA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UcJC1cmUxwf3UzTbVMwV8LKWTHl5H7Qnh19uI5cq5rLo3mID/jEVYDXnJOu4gEEXL
	 Opf775MsMIPnoyBIFAb5IrUued1xq3Eb6s3dVmDAC8MAPdxL+FAJvBSM/u8v7jK8OF
	 nvdLRzAQ95ypKmpD4aHKUVpmJM24f2/sj6bWoeIU8TOPStT5Bjd2l3v1aQ32GFJtta
	 paUR4tTT1IXdrOzmyGeBp5f/BvJiG1pYkmL+C1UFT2axOQImhpMUJCKVg2bTVX6EQ3
	 gT0GL04T+DtIvV0ME9fNFaTe35CkbsvfhC6iUKw5/RN0VQdScXcTxtDd+BL5JzUZN2
	 1XOTMgWb7lViw==
Message-ID: <sashiko-outbox-174742@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 12/17] perf thread: Expand context analysis
 annotations to threads and namespaces_lock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261016173106.679725-13-irogers@google.com>
References: <20261013222622.1822619-1-irogers@google.com>
 <20261016173106.679725-1-irogers@google.com>
 <20261016173106.679725-13-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 17:43:32 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Annotate shard and last_match in struct threads_table_entry with
> __guarded_by(&lock) and add __must_hold_shared()/__must_hold() to the
> last_match helpers in util/threads.c.
>=20
> In util/thread.h and util/thread.c, add __returns_ctx_lock() to
> thread__namespaces_lock() and thread__comm_lock(), annotate
> namespaces_list and comm_list with __guarded_by(), and add
> __must_hold_shared()/__must_hold() to the namespaces_list helpers.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016173106.6797=
25-1-irogers@google.com?part=3D12

