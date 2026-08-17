Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECAF53B83E1
	for <linux-perf-users@vger.kernel.org>; Mon, 17 Aug 2026 09:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786960192; cv=none; b=SIBsYTjPvsboIF/yt9JdEMM4JH9t4V3qb0mdwn5HZjQ6Y2k1YFA/uoO4oDkzrB7r9uOfat4hflykCWpSuAL685B7YTwS2aUBcvYbXqXte1W2wFrNxHc1Y3Y4efFcRZRBHj/zFVcifImclDd+623+TcWRFHejAr6ISMEDFeRXDwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786960192; c=relaxed/simple;
	bh=X7qgwSXvTmQeEf8VL9SU7Ox/MSLiNpGs7g5GGObZLa4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sne0OUX7atxT+X+OnHaRsgm+3AQgwo6ipJ/8zyUvwcoRwHvz3qn2BJn3NfH8Rzu4Yl7pdc8lOp+1LHti0UJm5Rhq9hmfms2noH+1ugBnxFIZbplCt5tMJvmzi4yokMD/kxUazzwxPSDs8EpRYzrJmivOx9LgWu59Bi2nERCvinY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ezee8Uzj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ezee8Uzj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68D5C1F000E9;
	Mon, 17 Aug 2026 09:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786960190;
	bh=X7qgwSXvTmQeEf8VL9SU7Ox/MSLiNpGs7g5GGObZLa4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ezee8Uzj/WicAAfMSp7KKOW3DtajPVirpXJm7q6RvTFEFYywy9ioq72Y4zMFTf0BG
	 HKWQSuvKBpJB9tYZJKo0o5Fw+deyRxFg+rX0ZgsqnEjLthMOYKhyz+2lAUNZiuJ4Ri
	 sCLLn9Ug05Kjt8sUBmx79RUjNugjtSe3mjCj1jB/r3BTmlvQnaFtXdTGsOvWpWqeck
	 DJN7u2/Ia8YtzZUCXaIZ4KGVKfL3Vzjiv+0e7H7lRN4M0MjtJdfrGZL6C3W3/67akZ
	 IzXXnQ6QBsR6G/b36R/fOdZPt+Z57VJF17LsGx4GYnMn4ccBsW/ztYqdGjyCrpB5KC
	 94jhMYfbhgOrA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 5/9] perf c2c: add function view stats merge and
 memory management
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiebin Sun" <jiebin.sun@intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260817094623.3288456-6-jiebin.sun@intel.com>
References: <20260817094623.3288456-1-jiebin.sun@intel.com>
 <20260817094623.3288456-6-jiebin.sun@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 17 Aug 2026 09:49:49 +0000
Message-Id: <20260817094950.68D5C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Add the per-entry stats/cstats aggregation helpers and hierarchy teardown.
> Child common fields are released through hist_entry__delete(), while the
> function-view free callback handles the private child tree and containing
> allocation. Also add a helper for pruning writer entries with no stores or
> cacheline children.
>=20
> These are used by the entry-creation and builder patches that follow and
> are __maybe_unused until then.
>=20
> Signed-off-by: Jiebin Sun <jiebin.sun@intel.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260817094623.3288=
456-1-jiebin.sun@intel.com?part=3D5

