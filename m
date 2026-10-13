Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15187E792;
	Tue, 13 Oct 2026 06:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791872612; cv=none; b=swpBDwErK01yqghVqoCqMUc6QqEpT/8Cc8j1j6RxzrnmfJ6nKDDc8zWx5MbMn30tFt8GWcZqoIKzG7M7yMYJbmkvx0MxQpbC3fvVFBeYWrjEpzXjp45hDZEARJNgX352xgTrwDqVOBO1U35rF75Z0/ZeaCB8sqMNm8tM8QQMNIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791872612; c=relaxed/simple;
	bh=2RxdJ8eyIbSjDAMARNsQORkoLlU666UVFx6wmYAFoco=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J1h5E3tvPoAfjLEqMoEp/qDAiseHCJ5VAwLU9mQ5pq6aZiw0CJqXFmz5hIgjjhRPYiva8FTYpHtcdeOP+xfUD/qBuf7Eu9vOYyMmW2dOCpYamcT55/YJX7pfSJKvtJ+swEVukhgMgLZd+KsiqzNPnBGedfiDIrdTU9E+idsrSEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E0jPLkas; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E0jPLkas"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62A631F000FF;
	Tue, 13 Oct 2026 06:23:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791872611;
	bh=7VeDI3+AG44Z4+rdiJ7V8VaILijSc8lNDhvAcM4p9zM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=E0jPLkasz0U7rlp4D06BwyAVw5VRyu6m1Hat+N1YfRzwdh3q88rQyyCywMdeHOtlh
	 21GvsAfk8+IktkKKUiM5KtXdRf5UawJeDK5S97P/uNMKCXd5C7obNhSpSPr0aNro3P
	 KOG3bZ83baERg/luoFfT2n23iPPgYq/+IC+rtr9ODAWOUb3qpq08+hkPYIImPq1XrS
	 061KWMLPTbU+EeGpbVg1AwZBKSkAPtNmB6AlsEA5C1fbXLFH1qYT3GxebkwK2Y5d7C
	 9bye2sMxAtapacYBCw42w5Fbo4RwmD+tZqSORsq6ApoV8VOYu2lv9UqogXVt9odFBm
	 FwDz/V7n7OkQA==
Date: Mon, 12 Oct 2026 23:23:30 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v3 3/4] perf symbol: Set dso symtab type for libbfd
Message-ID: <as3OYus0IUueVY0r@z2>
References: <20261012235938.87912-1-namhyung@kernel.org>
 <20261012235938.87912-3-namhyung@kernel.org>
 <sashiko-outbox-168776@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <sashiko-outbox-168776@kernel.org>

On Tue, Oct 13, 2026 at 12:08:01AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] perf: missing dso__set_binary_type() initialization for libbfd bypass
> --
> 
> commit 3d059164c2c17ae3b0ec344af1e8527af000eee5
> Author: Namhyung Kim <namhyung@kernel.org>
> 
> perf symbol: Set dso symtab type for libbfd
> 
> It missed to set the dso symtab type when the symbols are loaded by
> libbfd.  When it happens both syms_ss and runtime_ss may not be set
> and won't call dso__load_sym().
> 
> > diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> > index 4878d4292eb85..a90ce714b174b 100644
> > --- a/tools/perf/util/symbol.c
> > +++ b/tools/perf/util/symbol.c
> > @@ -1925,6 +1925,7 @@ int dso__load(struct dso *dso, struct map *map)
> >  			nsinfo__mountns_enter(dso__nsinfo(dso), &nsc);
> >  
> >  		if (bfdrc > 0) {
> > +			dso__set_symtab_type(dso, symtab_type);
> 
> [Severity: Medium]
> When dso__load_bfd_symbols() succeeds and we take this early return path, does
> this code also need to set the DSO's binary_type and cross-platform
> architecture flags?
> 
> By taking this goto out_destroy, the rest of the DSO initialization loop is
> bypassed. This leaves the binary_type as DSO_BINARY_TYPE__NOT_FOUND. Later,
> when dso__data_fd() attempts to read instruction bytes for perf annotate or
> Intel PT decoding, try_to_open_dso() will restrict its search to only
> BUILD_ID_CACHE and SYSTEM_PATH_DSO since the actual discovery path wasn't
> recorded.

As I said before, it should be handled in a separate patch series.

> 
> Additionally, bypassing dso__load_sym() means is_64_bit won't be set, which
> causes it to incorrectly default to the host perf binary's pointer size. This
> breaks cross-platform analysis of 32-bit files on 64-bit hosts.

Looks like a pre-existing issue.  I'll add it in a separate patch.

Thanks,
Namhyung

> 
> >  			ret = 1;
> >  			goto out_destroy;
> >  		}
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20261012235938.87912-1-namhyung@kernel.org?part=3
