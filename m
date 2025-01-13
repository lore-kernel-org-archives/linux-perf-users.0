Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018D91FBBCC
	for <linux-perf-users@vger.kernel.org>; Mon, 13 Jan 2025 15:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736780809; cv=none; b=V+aaaLmrEsQE5jcFSlyycWRQ76BMX8CjQa2OSuOoZcV/ThICRreviUSEg4iFxgZFz9XBVwh4/dArahi2Klw1exEq2ZBxl0U63yocM4dxNOeA+eVrwxI0MVrt7hg/ab1FVzaDsYD8/imgA6xKPoMgn7laVf8/QRNQEIbP1nav9t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736780809; c=relaxed/simple;
	bh=MnYPtt+wBgAFoKY6MEbLs4lijrZah08thJVWBEyzLe8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eJ0oPXICOUvLSgRfMmQ8472pgPFErA/JQvCHE5i5SGtR6AQ4tpSy/CziBXIYIj3IexehLyzlyVjfOoSj1BHWCvkMliUiZWTnYCb4vYIAWDT+V1VDsiuxGkIf6yOJLbo1TF0xP4kuT0miPQnZgwIbcqSoGAG292J1gkqi3DPffSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S2t3IIRL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S2t3IIRL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 374C4C4CED6;
	Mon, 13 Jan 2025 15:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736780808;
	bh=MnYPtt+wBgAFoKY6MEbLs4lijrZah08thJVWBEyzLe8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S2t3IIRLJbwWNbHsUs7K+ZDy8o+z42cvwFShCiefAXvZ71+VWXM+5rIYSCvW5+yeL
	 mwSMgj27u1KHezLA3CBM9DgAfM8zwCM/8fAc10IqtjkQZ9lSbsG2jWg3sR4r642MUa
	 5yVFTvS0WStCpwDPqrR5Yp0EN3KhAtYALjzPpCOIkrLe0vgzWQePVfPTEZdvrCKRlg
	 s/k98srRNshZ7OIGRLyqIgKeTpoYe726OFOKhYZHJt3m0vjql3Ov+3D7sh+fRPKfVK
	 WTnLYhkQsyNVinbWNFdQT9E2/apjSNipjxwsNFnz2ZeiELr/nla8pvxy5dCf6lfvfc
	 U8N3rG/Uq8WMg==
Date: Mon, 13 Jan 2025 12:06:45 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Veronika Molnarova <vmolnaro@redhat.com>
Cc: Athira Rajeev <atrajeev@linux.vnet.ibm.com>, jolsa@kernel.org,
	adrian.hunter@intel.com, irogers@google.com, namhyung@kernel.org,
	mpetlan@redhat.com, linux-perf-users@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com,
	kjain@linux.ibm.com, disgoel@linux.vnet.ibm.com,
	hbathini@linux.ibm.com
Subject: Re: [PATCH V2] tools/perf/tests/base_probe: Fix check for the count
 of existing probes in test_adding_kernel
Message-ID: <Z4UsBYLWa1CJfn3F@x1>
References: <20250110094324.94604-1-atrajeev@linux.vnet.ibm.com>
 <07be4391-4a28-4761-9171-26580aea6312@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07be4391-4a28-4761-9171-26580aea6312@redhat.com>

On Mon, Jan 13, 2025 at 11:21:24AM +0100, Veronika Molnarova wrote:
> On 1/10/25 10:43, Athira Rajeev wrote:
> > But if there are other probes in the system, the log will
> > contain reference to other existing probe too. Hence change
> > usage of check_all_lines_matched.pl to check_all_patterns_found.pl
> > This will make sure expecting string comes in the result
> > 
> > Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
> 
> Acked-by: Veronika Molnarova <vmolnaro@redhat.com>

Thanks, applied to perf-tools-next,

- Arnaldo
