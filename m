Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3E051DAF5
	for <linux-perf-users@vger.kernel.org>; Thu,  1 Oct 2026 14:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790864822; cv=none; b=Fxz4OFG4hDOtduAiOfiOn5TcwJdtVfQfpZnRdIleqoZ3XykXnElBRw6HN2CWzM2r2WEY5pnJ9ndsQeFBxLKS7PTV+FS9c3R7LtmrHcL+y4PMcFRSEQcgFZ5JfGU3hcAdWf3zw9JeysbYlrk6l6E4wF484QjhBrjvLhuNcGuUaW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790864822; c=relaxed/simple;
	bh=0OiD8VQMHdh2GZ6IltniLxJ7N0D5jeJ1ajRXT5zSQtM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KPTgkspAlHe7K0bGdubOSJSpf06L4DZVY79vQZ1bqSJ6I9sMf6Wn3lH0CpDFoQIKHbuHf0y7mFMrB5bP5yXLKBn+eR3ZBPWLsSNGM49NSsZywjWuVB/N+pXRgT16zyzrDONkjHuZdwgbj8L+i2p9TXs+6oOOk5PCmV2yywOPKMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E8Qc8kHV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E8Qc8kHV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 345AF1F00898;
	Thu,  1 Oct 2026 14:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790864814;
	bh=0OiD8VQMHdh2GZ6IltniLxJ7N0D5jeJ1ajRXT5zSQtM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=E8Qc8kHVHb2sIJKBOpLIKgWbImTlwhtELHmzvEzJaU8wzIW9nmy3R4ouA9Gdd2GsJ
	 jJBUp4FJSr/IOncD3ngL4XfBlK/F+nj3TghTzI2bu95BbcIoQv+JqrofVuooBjtToA
	 FCvFPKwmJrgB6Ahz7csra6QoJh1CBm06bTuWVf93fvenx9VpeAEtCAfbp+1xyGtKoM
	 0sPYYi6fgWJFj7zkonIm+dq9mR00NkVH19uxzYtvJZ1gl5MJuOfRR8XUkbzvJBYFSX
	 TbMvTKHRh16EtCBOJh5U/DkfRrz2OYx48vQ7jMkxLUz0nJixgM5Is8PDS9DHw+MK36
	 sO6njt12EWbtA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] coresight: Retry failed HW_ID writes
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Clark" <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261001-james-cs-retry-hw_id-v1-2-4d45ab46cde7@linaro.org>
References: <20261001-james-cs-retry-hw_id-v1-0-4d45ab46cde7@linaro.org>
 <20261001-james-cs-retry-hw_id-v1-2-4d45ab46cde7@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Oct 2026 14:26:53 +0000
Message-Id: <20261001142654.345AF1F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Don't set the aux_hwid_done bit when writes fail so that it can be
> retried later if the ring buffer was full. Add a second attempt on stop,
> which will always succeed if the stop's AUX output also has enough space
> to be written. If there is no AUX record then there will be no decoding,
> so the missing HW_ID isn't important.
>=20
> Signed-off-by: James Clark <james.clark@linaro.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001-james-cs-r=
etry-hw_id-v1-0-4d45ab46cde7@linaro.org?part=3D2

