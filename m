Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1006A248F5D
	for <linux-perf-users@vger.kernel.org>; Tue, 10 Jun 2025 18:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749580742; cv=none; b=neOubmJopRYJF9TtuIt/tHTkQhjm2u7vKrQTd9SUmjAWQRmC8xPmfBeH4radyF7Or8VjfxUZ6fHBWnzmDHHgj/Sil0NU/G7B/mtfjmPQTlBW75jOvggHfV3KXBGiB5WpFKCEB86CdVtZCUxYxgTWG5lvgmw0Or2zH6/5QLFnpsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749580742; c=relaxed/simple;
	bh=15pIpnNos5iGvM5I+iqupXCkoE9UJEv/zeYKHgc0GNs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=NFn9x33W7Mk17/bfv0UAJXEH/E2P5/jYwp58xZNpBGo7p/FGf0QkAqLVnAO2PUa5Sdsu4Li+oWWoT8D2M5j8Y/WVbdv2JeHV7JqeX13jw+8LX6Awl8Esm86OeZz5zHkFFGPq0oEbNscGCcKszHDSHiqVRhbDv4mFL0YDn3E+dso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I0ob59Ny; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I0ob59Ny"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1C06C4AF0B;
	Tue, 10 Jun 2025 18:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749580741;
	bh=15pIpnNos5iGvM5I+iqupXCkoE9UJEv/zeYKHgc0GNs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=I0ob59Nyq/3MxiBL2XSO4dkRSXKCwWB4JKdAiy/dbn7LtYFfgzr6wesxsqSTtiJqE
	 6M5mxw3AL4hne2c70tjpuIN967FwYbCYDd47hYge4/n/75GB1v3DzDvsyt+YSQAzBv
	 aAkt3a4uA8+xifjQ8UJS8QWoI+g4Q/QOQ+dC5v/D1Bd8I42byimA5I72q9uPL+Si05
	 0RilI23l96AK9DEuIgJMhOgKJihu2RYVW8mrx1NTxBvJuXAqEyBBYjwFCJX+c4ZIIg
	 xyvRxc0MSMdWV/lvpbREJ1xRoZtuO/FmIJD6+zsxLple4Pme8VkfPHdEqOqEYxjVmY
	 acFI6gl2Nxj+w==
From: Namhyung Kim <namhyung@kernel.org>
To: linux-perf-users@vger.kernel.org, 
 Aditya Bodkhe <adityab1@linux.ibm.com>
Cc: Aditya Bodkhe <aditya.b1@linux.ibm.com>, 
 Disha Goel <disgoel@linux.ibm.com>, Adrian Hunter <adrian.hunter@intel.com>
In-Reply-To: <20250429065132.36839-1-adityab1@linux.ibm.com>
References: <20250429065132.36839-1-adityab1@linux.ibm.com>
Subject: Re: [PATCH v3] perf script: perf script tests fails with segfault
Message-Id: <174958074175.4039944.2017691718666760818.b4-ty@kernel.org>
Date: Tue, 10 Jun 2025 11:39:01 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Tue, 29 Apr 2025 12:21:32 +0530, Aditya Bodkhe wrote:
> perf script: pert script tests fails with segmentation fault as below:
> 
>  92: perf script tests:
>  --- start ---
> test child forked, pid 103769
> DB test
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 0.012 MB /tmp/perf-test-script.7rbftEpOzX/perf.data (9 samples) ]
> /usr/libexec/perf-core/tests/shell/script.sh: line 35: 103780 Segmentation fault      (core dumped) perf script -i "${perfdatafile}" -s "${db_test}"
>  --- Cleaning up ---
>  ---- end(-1) ----
> 	92: perf script tests                                               : FAILED!
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


