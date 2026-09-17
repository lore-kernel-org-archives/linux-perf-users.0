Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A23581226;
	Thu, 17 Sep 2026 14:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789654079; cv=none; b=NMYzMmDb58mfko6Pc9VMN2wWBHfA1SCtwvw8wuUH8DX47r149p628l1/TlJ/ju4gJlClf9SzVnPmo3uQrHPOPcPYjXv82IQn0L3/M36k4WNmfGqNrIOE5C5v5AVLJGbKujb43iRe9ZOmunF6z5uSYcgNJSONHwRNyiTbqlNSluA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789654079; c=relaxed/simple;
	bh=VuyF6Rwcw0cPFG7OIlDw4QBgYZ3437SHJegGTjh3mUI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CldwIs2cBP3Nn8CQRKdpMoGWv6sz018ouFVoizizCN3YOD4WpJmHcTYMSzh33zD8fMArRJVB9PeUHAfEuHWqsa9axRcVvCYJrmrKbv4hBnaG1+U5xWJBhRJ9IoiraIh58UwkGcDgrG1AA9uCfQqhgbFyDSLOb456oteajIUQ7l4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YLG+wKzp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YLG+wKzp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F21F61F000FF;
	Thu, 17 Sep 2026 14:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789654068;
	bh=HcO/OB/KFfFsuo/q83Ez3JpyjhwFpQ4df9kj05hfmyk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YLG+wKzp7p5F83PWoA14QiYlhPIYgp+fjG3QZk+jFWNIbeQVSpbv5Qv2y58iFc96W
	 8KzZNuZomcnJ409dQRdxz+fsikfQ3HhyembNw/NF17prOW8k3qEP6W0vFbKer7AYJC
	 ZqUrYI8Zkkp/fHwwiphJqMnIgpTwVesDzloQEh5W8wNBXUtfWUaRmyDP1GFeZQkLGl
	 Bp0x/Sm7N+1olvXkMMGHy4FzqZeKdalspIUHGlkSxbJobr3JBn30PC0ORJYqNawRzy
	 iGNjvYUGpemisGbFcp2DHqWMQJk5n8PKEjNbxC8OhS5v0ZmaXjIhWUM6o7nN0xsrem
	 7bypy2HHZ3d/g==
Date: Thu, 17 Sep 2026 11:07:45 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH 10/12] perf annotate-data: Resolve type DIEs in the debug
 file they came from
Message-ID: <aqv0McncIOv824SJ@x2>
References: <20260916114740.48230-1-acme@kernel.org>
 <20260916114740.48230-11-acme@kernel.org>
 <aqsN1si6jjWrocIQ@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aqsN1si6jjWrocIQ@google.com>

On Wed, Sep 16, 2026 at 02:44:54PM -0700, Namhyung Kim wrote:
> On Wed, Sep 16, 2026 at 08:47:37AM -0300, Arnaldo Carvalho de Melo wrote:
> > --- a/tools/perf/util/annotate-data.c
> > @@ -242,12 +261,6 @@ static int __add_member_cb(Dwarf_Die *die, void *arg)
> >  	strbuf_init(&sb, 32);
> >  	die_get_typename(die, &sb);

> > -	__die_get_real_type(die, &member_type);
> > -	if (dwarf_tag(&member_type) == DW_TAG_typedef)
> > -		die_get_real_type(&member_type, &die_mem);
> > -	else
> > -		die_mem = member_type;

> >  	if (dwarf_aggregate_size(&die_mem, &size) < 0)
> >  		size = 0;

> This is gonna conflict with my change. :)

We can get yours first and I'll adapt :-)

- Arnaldo
