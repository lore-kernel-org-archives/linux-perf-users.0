Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F12013A276
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Sep 2024 20:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725480155; cv=none; b=cX2C8vIyM+kelDdORGwQt5JZauClLu4Eeha52HLdDK2LGGKKdazarRrCjf4CZbtxWibpus/g9gY+aHH60tA5JI8PHe0+biq2nqjFhp0JzDi9CCmC3VDXsU/GBA7Llqjzn6Nfu6horvLIdCxnvtOdBI/XOBHjnKl8156f0lkje4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725480155; c=relaxed/simple;
	bh=0/DdoeycAMIrS5gdB5NolfMqmVy3ELsCxo4ZReYkuUA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lodtv0snmnGncS2wS4ic1ZJCElABaHPS9Wtmd8CSWMvTbN1craouEGcfgbZk3umooQ3jIRNou13fa2lTOz0qLyux27N34UxvIhm+VkvPYdNMSjCpl97C3husG3mA1FH1aXa0pmnDukJsm9w9yQtL4mIsQAsPKbPMKcalVyaZUjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fQOQhd54; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fQOQhd54"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 350CBC4CEC2;
	Wed,  4 Sep 2024 20:02:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725480154;
	bh=0/DdoeycAMIrS5gdB5NolfMqmVy3ELsCxo4ZReYkuUA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fQOQhd54juZs0jZ4IL0dP0S24z/CjJFp9w1oxMMTtMb+dfOFw3o0VuJighIfskZYw
	 GqEvxLMSLj7hiqqvhf3HysAZUX6ip3evO96mckr8GMT05gAP2N0S05YfT5YuvQl+4F
	 eHikcsnl8gUiWeRo/lZmFBSSayxpXg8FPrxjYK0l0qa3k8Tl1wnUk4aTd7KMDrTtoH
	 MOw4iHAUAR9NnpEhOGCY+pMlQM86o8RlSDN3Lin6vIcsjZ36QlviPHtxhGIb+MP+aS
	 cAiOR8GJx1P/gfDxlqaqLQB9qGl2QgX9QyDd+t+ZdxsXVhKionx+usFUSqLDnciuBe
	 VjahQxykQo0iw==
Date: Wed, 4 Sep 2024 17:02:31 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Aditya Gupta <adityag@linux.ibm.com>
Cc: jolsa@kernel.org, irogers@google.com, namhyung@kernel.org,
	linux-perf-users@vger.kernel.org, maddy@linux.ibm.com,
	atrajeev@linux.vnet.ibm.com, kjain@linux.ibm.com,
	disgoel@linux.vnet.ibm.com
Subject: Re: [PATCH v15 7/7] perf: Add more features to supported_features
 list
Message-ID: <Zti81yV0jRIB7oQ6@x1>
References: <20240904190132.415212-1-adityag@linux.ibm.com>
 <20240904190132.415212-8-adityag@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240904190132.415212-8-adityag@linux.ibm.com>

On Thu, Sep 05, 2024 at 12:31:32AM +0530, Aditya Gupta wrote:
> As suggested in [1], add more feature names and corresponding names,
> based on the information in Makefile.config
> 
> The entries were added after seeing the corresponding -D option which is
> added to CFLAGS, based on the presence of a feature in Makefile.config,
> such as:
> 
>     ifeq ($(feature-file-handle), 1)
>       CFLAGS += -DHAVE_FILE_HANDLE
>     endif
> 
> For above feature 'file-handle', corresponding entry has been added to
> supported_features as below:
> 
>     FEATURE_STATUS("file-handle", HAVE_FILE_HANDLE)
> 
> [1]: https://lore.kernel.org/linux-perf-users/Zn7EvDbsnlbLXj4g@x1/

I'll remove this now because there were some that sounds really strange,
like:

acme@x1:~/git/perf-tools-next$ sudo su -
[sudo] password for acme: 
root@x1:~# perf -vv
perf version 6.11.rc3.g15dc9f274b8e
                 glibc: [ OFF ]  # LIBC_SUPPORT
libslang-include-subdir: [ OFF ]  # HAVE_SLANG_INCLUDE_SUBDIR


The first one is the strange one, how come, no LIBC_SUPPORT? glibc?

The second looks irrelevant, I'll see.

- Arnaldo
