Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8A33E9C05
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 17:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790184139; cv=none; b=upSvqDJO93KCCXybPRrL0p3og8ef4paJV4kO0hl/UtXHfBU95VVKfsdCa/g+L+QufYYcQQFFjd9PaiVdckLIrDHCB7Fpn7hvlxjd57tsBIEfF4bE+p478rApnjviPKZXAMCFOeCxUGTW5YiqxR0G9+x0MMcrzXPaoYSijWPTf1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790184139; c=relaxed/simple;
	bh=SR+ss/NwgClWIZgZKB/DMeb1L1C21Uy4C1q1opdcauo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aZPLawpDJp1NAN0oem6pJKYuxw2BBs0dKyyNVfwS/9wypJdFtWJ0QxLPinl6HwHXI+VSpq8IqO2vFz7xbcyZ3iRs+YklY2/qADelf1W5zvVYOg1cIEaLjlgvMaHnypUx8h8Gq6e5VkAXF+z72BK/gXBtbaE4LZVrZ1xM+aaaWZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hY7hKBsg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hY7hKBsg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9509F1F000FF;
	Wed, 23 Sep 2026 17:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790184137;
	bh=r6NVPvHBmdYUlHUwMmvf7Z7/uaTF1Xurvxr54Fg08wU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hY7hKBsgrv8gJPLG+Yhrw0MYoy+HpQU0ujUR2NbqP+Eh0khEaz4i6vSrNBZlaF8qg
	 s/DMEVSbgqpOR9tBOzulzUGmeCTqEfjBgn3Jx+Kv3ChgbEkvKMBjCggbhCqneFCYgF
	 6c22PeKTs/MN8aEfsemH83Dlol7hUCFs5/N5PY6Sdd9eNJd4rVq8n8kRcJwccNaaQI
	 1lyR+7eN5vNpCoD3ksHfVPNs0/anbVI0s6nKCZZpoWdXzLf36s4HvtHT/8MWCaRmzx
	 982Xqn27K9M9i05Z1nL915h4xW10tuuyb2eL98pOPwTC26tB3IqkpY5Hwd8aHfe/5+
	 5zhVpr+vivwBQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 5/6] perf tools: Show memory region in perf-script
 subcommand
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Falcon" <thomas.falcon@intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260923170903.48388-6-thomas.falcon@intel.com>
References: <20260923161043.95C171F000FF@smtp.kernel.org>
 <20260923170903.48388-1-thomas.falcon@intel.com>
 <20260923170903.48388-6-thomas.falcon@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 17:22:17 +0000
Message-Id: <20260923172217.9509F1F000FF@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923170903.4838=
8-1-thomas.falcon@intel.com?part=3D5

