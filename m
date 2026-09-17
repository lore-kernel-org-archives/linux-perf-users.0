Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E61E374185
	for <linux-perf-users@vger.kernel.org>; Thu, 17 Sep 2026 02:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789611021; cv=none; b=Fi9IaN4Tmp/2DbE2+E3skbb7C50xMsIOynYabLKDfZExT2xk6J5jlQcLW0MeGXQTWyYAZ43Sd0o/Ot5J8qosxf9uORnBechxiIGFaeab7cymT4j6xHHL2RiIyWbPv78ojaLHY//H1HUEk0wMkw4gwj9EV9CC2YOn4xvhD8fJoI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789611021; c=relaxed/simple;
	bh=oDsFC1mZEoTCmI8XtF+EDfFL/RPb6OF3+wA8/1xKPH8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RDb81RNsgabSLlFBZuDW0qLrCQVKFj4v7GyJUrMTaoCXsZ/zGx9EtrDpAC9Sjr46VcIqvhLeT2r3j1NMZ/htwC+9yl1HrHvmoyn1J5gwJ13Kpql5Xod/19OQaag//IopC+WX1bvHPALA1bWA0n9SAZx13aZ9f/53nM7cGliNZGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X0Qfp82A; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X0Qfp82A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9439A1F000FF;
	Thu, 17 Sep 2026 02:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789611019;
	bh=oDsFC1mZEoTCmI8XtF+EDfFL/RPb6OF3+wA8/1xKPH8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=X0Qfp82ABcV6pJnFsoLvjCwLuc4y85FxWL56JzkEVnqT5IKir8CHjWLrFMu7ntAug
	 f2goSX4W13AmeJ1NIZKYR7eKMmjNzAeFGZjsWsZYRs6oOJJ2hcd8GOTIY7EoNuZhaa
	 eQKi6rbBCS5gTMspR3b3HxPvGWmm+cXtpWu3KJobAPZjIenQzyjYf2vz5TmUv0g/Xm
	 11vCljIir0ivCbKlQ23qxhyqugBJ+oca3u7tn2DIkKrno/Udi6a5xsI4/+1CTXupBr
	 byHzhG2Tjhh22t/ADJqJwtTu5m3K4ieQRN6OnZerHVvlKD4++vvrVUSTOqDQ9bx/eH
	 vCuXxKH2YD9sQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 05/12] perf/x86/intel: Remove incorrect LionCove PEBS
 data-source constraints
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260917015234.981153-6-dapeng1.mi@linux.intel.com>
References: <20260917015234.981153-1-dapeng1.mi@linux.intel.com>
 <20260917015234.981153-6-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 02:10:19 +0000
Message-Id: <20260917021019.9439A1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> On Lion Cove, PEBS data source is valid only for the events:
> - MEM_TRANS_RETIRED.LOAD_LATENCY (0x1cd)
> - MEM_TRANS_RETIRED.STORE_SAMPLE (0x2cd)
>=20
> The perfmon database (https://github.com/intel/perfmon) previously
> tagged additional memory events such as MEM_INST_RETIRED.STLB_MISS_LOADS
> with L1_Hit_Indication, implying PEBS data-source support, which is
> incorrect. The database has since been fixed, but
> intel_lnc_pebs_event_constraints[] still follows the old definition and
> marks those events as data-source capable.
>=20
> As a result, get_data_src() may decode data-source information for
> events that do not provide valid PEBS data-source data and mislead
> users.
>=20
> Remove those non-data-source memory events from the Lion Cove PEBS
> constraint table so matching falls back to the regular non-PEBS
> constraints, which already provide the same counter constraints.
>=20
> Also update lnc_latency_data() to decode LOAD/STORE flags explicitly
> when setting memory operation direction, for consistency with other
> *_latency_data() helpers.
>=20
> Fixes: a932aa0e868f ("perf/x86: Add Lunar Lake and Arrow Lake support")
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917015234.9811=
53-1-dapeng1.mi@linux.intel.com?part=3D5

