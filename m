Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D641E3D8127;
	Wed,  8 Apr 2026 17:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775669386; cv=none; b=TbEGfclLbGI8USYPlFNbSn9r/ilr5KPb/jDJ6GSX+qj8AjGMVKQ40TUfCmdu3tOjY/OpmEY5zYi/I5hEF8zlHirqbx2/T9W6qiIoWxLhTk/0hZBBIvxNbVj+Au5JSTr9/JFDiD+Omk+UYWS3yL34unwvtOAmpFifj3dz7sPds/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775669386; c=relaxed/simple;
	bh=20dzDEPmCNgtZzySvX0sb/v5ewi+sL7AhBW7xWB0qnY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=B4BQpaeXak5owOdxeGN1mkMXogdJprwJQMy6WoyiFGENJcByEaN9jxQFKdWDi/XErus9u8IFy7biM/1+ZjlRCFmEIpM/inMFJ5hkIcioh8wCqQ1nlbxCemKMuAtkHDN1MgI6oFptlF0TD0Tz8PQ8OXZLuhhZSaA1fm0iAjCccTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sNFcEjWI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sNFcEjWI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51CE4C2BC87;
	Wed,  8 Apr 2026 17:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775669386;
	bh=20dzDEPmCNgtZzySvX0sb/v5ewi+sL7AhBW7xWB0qnY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=sNFcEjWIfBcr4e+r0qM/p8xNLGDbKlA8JSv1JZgH96uQepfhMXVH9+vA65l3K/Yht
	 UE+4O6R7+5k6BAG5eAJX2a9lvOQqMxi5y4TzACIwhMSH4gILjtlqvseEeu6Nu9DZl8
	 zRKS3TzIHwCoRnZZ2O6Cf/MwZ+lvzyhDbaL6ivBB6ELVurPrCiRZuui+sSM/bx6Nhm
	 bMDcBn/z2pK1/RBbtHxDJ65hQyDYC+RROF8qxRofEZ52WSMH7Zf7fP3esvVQMglO//
	 79jwUpOVhuprokWV94OCXriEc/SbnbRdl8Jy0Xvii4QKwvLqdaop51nfVTica5fOZd
	 6cazyGPZCLQjQ==
From: Namhyung Kim <namhyung@kernel.org>
To: acme@kernel.org, Ian Rogers <irogers@google.com>
Cc: adrian.hunter@intel.com, alexander.shishkin@linux.intel.com, 
 ctshao@google.com, james.clark@linaro.org, jolsa@kernel.org, 
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
 mingo@redhat.com, peterz@infradead.org
In-Reply-To: <20260408020838.166906-1-irogers@google.com>
References: <CAP-5=fVqaqNo1VyGPWhZ+DvEv+oRUU=sMtBtpFbm4D-sJb-JNA@mail.gmail.com>
 <20260408020838.166906-1-irogers@google.com>
Subject: Re: [PATCH v3 1/3] perf maps: Move getting debug_file to verbose
 path
Message-Id: <177566938629.2704582.5298990549974491624.b4-ty@kernel.org>
Date: Wed, 08 Apr 2026 10:29:46 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Tue, 07 Apr 2026 19:08:36 -0700, Ian Rogers wrote:
> Getting debug_file can trigger warnings if not set. Avoid getting
> these warnings by pushing the use under the controlling if.
> 
> 
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


