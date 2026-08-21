Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3559470E8F
	for <linux-perf-users@vger.kernel.org>; Fri, 21 Aug 2026 09:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787306179; cv=none; b=bmbVx7CgdXqNz43VbpnXA61bHn+hiT4y0nMNVZzUYHBXziMpSJM5jQiiGmXJqrjRbLW4Kbf9XvobVe9Zbc3yvaaD4SonfueYvqIPN+6SjQgTjVuCEgude3m91dt0eKprwwc+9/dlPSgj+5zWBzC5/ZjW2sOJv6B3qwdMWorR6J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787306179; c=relaxed/simple;
	bh=joG9CYdQBp92lpLgEsy7VyUhFbnFzJkWMkW8lYXn6yM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MZv0Lg4zJMjJEyl1Q2jdjaSzmp4UaZHGeFx9BGRcpjvHcMr/5t9BRdVH2Rzs+8iOp0D33rLVvMJeC6H4nDFypvPuxhAYmDSedOR5AdusIkY0yWNd7TzmDt/+pcnSet2Vhhe8z5NibS+3h5tTz8BhpLO+qAFt/hHQZ0ZEJVDHUE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oYLtn1IU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oYLtn1IU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5555C1F000E9;
	Fri, 21 Aug 2026 09:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787306168;
	bh=joG9CYdQBp92lpLgEsy7VyUhFbnFzJkWMkW8lYXn6yM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oYLtn1IUh062+fDKTDZi3hZINOGSmIcCnTBa0Fw2tfiBdmXJswZ2E6vJPJTeB6N/U
	 J0WdUYsolnOo9rh9Rwoq9rPSfXwAzdD6YnFzm+zjkWDJyL3NXs/SodBwMQhD4oc54O
	 TUyvOp+w3fogo6GPv/gNaPdLERJOC+S9wJANOxcmZZIl/I3fUUqj44nrRrDX8mneuv
	 02He2I0DRVKPUCygMrD1OzWGAOQhpiaDUhjNtnTKMKjrfdQgKV72y04Pk9Qi/8K0jS
	 v6wQlV49Sfa4Ghp5SKOiP3xYAkRyCKemyh1sL2UgPGhU2LQ3ZKNTjE+TabZRLRMqqQ
	 KaokEDf90Q13w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 09/14] perf cs-etm: Queue partial AUX records
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Clark" <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260821-james-cs-unformatted-per-thread-fix-v2-9-00c4fd0701b4@linaro.org>
References: <20260821-james-cs-unformatted-per-thread-fix-v2-0-00c4fd0701b4@linaro.org>
 <20260821-james-cs-unformatted-per-thread-fix-v2-9-00c4fd0701b4@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 09:56:07 +0000
Message-Id: <20260821095608.5555C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> In snapshot mode AUX records may straddle the boundary of multiple trace
> buffers. Currently we only queue AUX records whose range is contained
> wholly within a single buffer.
>=20
> Fix it by queuing any partial AUX range that overlaps any buffer.
>=20
> Signed-off-by: James Clark <james.clark@linaro.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821-james-cs-u=
nformatted-per-thread-fix-v2-0-00c4fd0701b4@linaro.org?part=3D9

