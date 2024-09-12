Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C271BF800;
	Thu, 12 Sep 2024 19:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726168531; cv=none; b=rxsMUJH4MRJwBA/sNwM1WEMNgMYXAAOV2KUHecv9WSLbNivzT1XXIQbFHT8Ljgvcatd/zIoZfFkNOoL+uW0+8xrfvKg0JcRzT1e9AXewx3XvmOajPtomtBK86S78FJi42eH9502/mqre1Oy29+xUYl/Q/JbJ4oApaL5091VHgyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726168531; c=relaxed/simple;
	bh=i6kW9q1FHc0MK5mlEKOQt7m4/OzA6jKbkts9pxUqLvo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sA0ctSvLs9mwKuiaEckPCybEsjTgDX/jGcOh63mgmkVpv+T07D2BwJk6ifIueGYz6iqNoqAGsGzB6QJAIY4eOLA33pKfXxjIBEbUxgtjZKJQv56KXDBRRtLlNSB3UkcItL5/umgaO6wVtPRgoARHVgTVrTObXRoaOzBLGjnwU+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UyUIJvQ6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UyUIJvQ6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBC91C4CEC3;
	Thu, 12 Sep 2024 19:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726168530;
	bh=i6kW9q1FHc0MK5mlEKOQt7m4/OzA6jKbkts9pxUqLvo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UyUIJvQ6aut9qz0sLZEygKSScs314XKsCiaTQ7kDwXrbthFUD158wY8afRYBGwCEb
	 DWD0lvtREkHJS7kIVFhO5ylH5XEWkomZWAsmF3wcX5q8tBzwdEdhJPjCa8+6cdzPTB
	 5KXHFWFtg/OYm+6jt+Beh3vv7J+qgpy1mRxM7HHiaXUhWTjvZg8RkzuFemkOhe8yhl
	 O8FbrkaF92slnDKAzEElH2nb+5W41aNqON4q3V1OjQRQfGrBxj7zGElA7z2dmU4J7T
	 RDqEV1mGiVZuaSSpafXYymBCYkhq/UKB2YeZlUPz2YYZrdidy6oY4hJz+ziKnjeeWq
	 zF82CGf9U1OIA==
Date: Thu, 12 Sep 2024 16:15:25 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] perf vdso: Missed put on 32-bit dsos
Message-ID: <ZuM9zc71XXXZ3eRZ@x1>
References: <20240912182757.762369-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240912182757.762369-1-irogers@google.com>

On Thu, Sep 12, 2024 at 11:27:57AM -0700, Ian Rogers wrote:
> If the dso type doesn't match then NULL is returned but the dso should
> be put first.

I guess we can add:

Fixes: f649ed80f3cabbf1 ("perf dsos: Tidy reference counting and locking")

?

- Arnaldo
 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/vdso.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/vdso.c b/tools/perf/util/vdso.c
> index 1b6f8f6db7aa..c12f5d8c4bf6 100644
> --- a/tools/perf/util/vdso.c
> +++ b/tools/perf/util/vdso.c
> @@ -308,8 +308,10 @@ static struct dso *machine__find_vdso(struct machine *machine,
>  		if (!dso) {
>  			dso = dsos__find(&machine->dsos, DSO__NAME_VDSO,
>  					 true);
> -			if (dso && dso_type != dso__type(dso, machine))
> +			if (dso && dso_type != dso__type(dso, machine)) {
> +				dso__put(dso);
>  				dso = NULL;
> +			}
>  		}
>  		break;
>  	case DSO__TYPE_X32BIT:
> -- 
> 2.46.0.662.g92d0881bb0-goog
