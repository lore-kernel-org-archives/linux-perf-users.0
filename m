Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E10F542806
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 16:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789577415; cv=none; b=qxSqX2KaxFJgyknRAg+YEYaaLtMJnFuqSngwMgQJXqlXcL4MVvLZHRfZGf82pM6b3EBRp/Vr7rJxblLIYrjYUIMOxAf5L43ucS0njRRtnxN5egenUAn4QHwb6jWGxk+5MsGDonz+K8j36Zo+Ca/AHwyC1wUJ0DujRJiJVBzXnSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789577415; c=relaxed/simple;
	bh=flHCuGFhZiPldVCxd9xFSUgSEFRV7T12Ls96smQPAjU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Q4r+7NqfQdj4fBYDjdqnkrEK2hlATRv8i2on77zm9Yb9TdLNx4bU5xmrRGBHmjznJlUYApvvYLpXGTs3tfQd6acuWqD24X9A1IfyeUqZWwA1OhwY9SUlMb6WgSLt11q9xPG/xv848r9sLmTxRaUk1nAdDf1NtopMTCTvHk3l8Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OIQllavL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OIQllavL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ED2A1F00898;
	Wed, 16 Sep 2026 16:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789577407;
	bh=4NTlvmI3ZTVHlZCywhORWLnGzyPL/SYvUn3AJrgptsE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OIQllavLxVYHeeFBJYlb5g7X19Io1LIUfLDmgwR6FgoJRwIN/Ha/PasR19dSAOJLw
	 PJZrFlz9iWf3XTslICp3+dFL6Axvkoq/FBlzv8tjnVVM45dlSwxIcHuXD+bQAg3ycD
	 pj+qvRKBxbMpCN9EeC4pjkU30hEe8esUw2xmHcDvLNH5busPbDz5B9guUn9zWhVziV
	 ddnpUjBbZgXx6nPsIVvMRMNGcQ/NYJt76fgh0KZwcAE0gwc7IibKnHuDcIW5AcWGiq
	 gm7kjdNnzCrDrLqNhXX2AryGXn5w7y5eoF7mCt23vCXy4YhsFs7wS6FOey18B8f+f1
	 UoSmj+KgObevA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 5/6] perf tools: Show memory region in perf-script
 subcommand
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Falcon" <thomas.falcon@intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260916163127.318885-6-thomas.falcon@intel.com>
References: <20260916163127.318885-1-thomas.falcon@intel.com>
 <20260916163127.318885-6-thomas.falcon@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 16:50:06 +0000
Message-Id: <20260916165007.3ED2A1F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Dapeng Mi <dapeng1.mi@linux.intel.com>
>=20
> Show the memory region in perf-script subcommand. Memory region is found
> in the mem_region field of the memory information data source. This
> field was included with the introduction of support for the Off-module
> Response facility (OMR) [1] in Intel's Diamond Rapids and Nova Lake
> Architectures.
>=20
> An example of perf-script output with the new memory region field is shown
> below:
>=20
>       thread 5/0 ...	|OP LOAD|LVL L3 hit|SNP HitM|TLB L1 or L2 hit|LCK No=
|BLK  N/A|Region Local-shared-cache              ffffffff9f002aba
>       thread 2/0 ...	|OP LOAD|LVL L3 hit|SNP None|TLB L1 or L2 hit|LCK No=
|BLK  N/A|Region Local-shared-cache              ffffffff9dc54c95
>       thread 8/0 ...	|OP LOAD|LVL L3 hit|SNP HitM|TLB L1 or L2 hit|LCK No=
|BLK  N/A|Region Other-non-shared-cache          ffffffff9dc54db3
>       thread 0/0 ...	|OP LOAD|LVL LFB/MAB hit|SNP None|TLB L1 or L2 hit|L=
CK No|BLK  Addr|Region N/A                       ffffffff9dc54db3
> [ ... ]
> Reviewed-by: Ian Rogers <irogers@google.com>
> Reviewed-by: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> Co-developed-by: Thomas Falcon <thomas.falcon@intel.com>
> Signed-off-by: Thomas Falcon <thomas.falcon@intel.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916163127.3188=
85-1-thomas.falcon@intel.com?part=3D5

