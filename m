Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B50938F9C
	for <linux-perf-users@vger.kernel.org>; Thu, 30 Nov 2023 13:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A9AxVWpK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 814C7C433C7;
	Thu, 30 Nov 2023 13:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701351232;
	bh=HgoI7ojKDquoGgFUCC8EqY2sI+gJka0wR4HG8LoH9RU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A9AxVWpK1bi0roGEwMFk9s0+ym38hCVatmtL4g+UeJJCXgXYXsiA2IvrgwO0s45ag
	 DH5Q/c93Dy3QLn5srpTPYC8DsRJPkjlR3ONroVVbd2zQX5LY7K3zImgbQZzwDlHXTe
	 3iv/ahShvuOv8azUAkldWfO7lBP8FzZ1j0M5O6hAtnSp+JHv4U1KkSJd70xaVivl24
	 Sp2npLbObIK++iAPDNWPQvpclLV+Hy+8bRMde5Ow89TtpvFL7sFMjB58QSDnJB+Peh
	 kURfCJYBAEwalsCbU97kWopyZFK0jLbiSNStvkA0HuuTKUawCFhMb9o6hkKGc85kKo
	 e90z/4IJk2YMg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id 1D84140094; Thu, 30 Nov 2023 10:33:50 -0300 (-03)
Date: Thu, 30 Nov 2023 10:33:50 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Aditya Gupta <adityag@linux.ibm.com>
Cc: jolsa@kernel.org, irogers@google.com, namhyung@kernel.org,
	linux-perf-users@vger.kernel.org, maddy@linux.ibm.com,
	atrajeev@linux.vnet.ibm.com, kjain@linux.ibm.com,
	disgoel@linux.vnet.ibm.com
Subject: Re: [PATCH v7 0/4] Introduce perf check subcommand
Message-ID: <ZWiPPtwhWHAFfpX8@kernel.org>
References: <20231116213435.382484-1-adityag@linux.ibm.com>
 <ebgef776v5uvigu2mqkj5mba36cewrhrxzo63fbczrcvyqexlt@nebkf5roy2gv>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ebgef776v5uvigu2mqkj5mba36cewrhrxzo63fbczrcvyqexlt@nebkf5roy2gv>
X-Url: http://acmel.wordpress.com

Em Wed, Nov 29, 2023 at 12:39:43PM +0530, Aditya Gupta escreveu:
> Hi Arnaldo,
> Can we get this moving if the series looks good ?

I'm testing and applying it now.

Thanks,

- Arnaldo
