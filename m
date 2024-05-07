Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749131A2C05;
	Tue,  7 May 2024 23:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715126276; cv=none; b=eBmNx3rIAmWjLXAaxwKooylMs2jPrXG/9qU+R91s6qh99R5EFGe0qZqY0KJeThO3Z8DRmFhkhp0Xse+ATgilHnl/fEOyUJnSvlHCSa5S9aDJLVHcT618JhsM91odD4xfF6BF34MxtdIPHP0ZORZ74H3QHh7jfANe7bcR7A5b2gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715126276; c=relaxed/simple;
	bh=u4y6bm9T98w2O0nxzxQv6wXthaTemHVgGjKBpl1iA6w=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=O5ErDjH9+SO/W1x1YeOfgJpCBtEBmeq2Wf0G5HbvhKEkrDrSPl7RQETadFWLvSEkGsFJFTHYu/1bZ/8tRRblvCt/1aYYg369w1+ffH7UqKphlWWivZBGhdB6HBgNLOlo3kJqfIbcFVqDneMJ8/uVKxYaWt0OuWMiGpgQfEJe3/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ROawISFc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ROawISFc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A345C2BBFC;
	Tue,  7 May 2024 23:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715126276;
	bh=u4y6bm9T98w2O0nxzxQv6wXthaTemHVgGjKBpl1iA6w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ROawISFcDVWDM6CB2v8B6Kf6rcPEdS68hDm1K4EQ6Ao2C8WGuvVDCBcBVlpx3nrP6
	 CDdaUpYETWj26vVqx0ZJiB4x3jsXQ8kKi/9omhioCmpopL/kIiaYLVWMQkbVtlOBmA
	 esDvDYxxkvVAS7mFjKqZlNlpQnEfabauWgEXeFtlpk6b0KXKQKAVPv0TUjL7cHgDVL
	 Rc3evIbaVvvsW/zBvgNcT+2SCSgfaVDZoBVnnyEc8MF+C6HAwitVONt/rVKvw2vPG3
	 Cws/IbXzJLhpzarrTYtCe3/snSPrm5+xtBbnGZ7PzmJrXEvWy4FTVJZgz977eSobT0
	 HLQH1UpJFbr1A==
Date: Wed, 8 May 2024 08:57:51 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers
 <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa
 <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, LKML
 <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, Masami
 Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH] perf dwarf-aux: Print array type name with "[]"
Message-Id: <20240508085751.a1a5dbd31e1fa7d4e80cdd85@kernel.org>
In-Reply-To: <20240507041338.2081775-1-namhyung@kernel.org>
References: <20240507041338.2081775-1-namhyung@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  6 May 2024 21:13:38 -0700
Namhyung Kim <namhyung@kernel.org> wrote:

> It's confusing both pointers and arrays are printed as *.  Let's print
> array types with [] so that we can identify them easily.  Although it's
> interchangable, sometimes it can cause confusion with size like in the
> below example.
> 
> Note that it is not the same with C syntax where it goes to the variable
> names, but we want to have it in the type names (like in Go language).
> 
> Before:
>   mov [20] 0x68(reg5) -> reg0 type='struct page**' size=0x80 (die:0x4e61d32)
> 
> After:
>   mov [20] 0x68(reg5) -> reg0 type='struct page*[]' size=0x80 (die:0x4e61d32)
> 

Good improvement!

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thank you!

> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/util/dwarf-aux.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
> index c0a492e65388..ec988f294497 100644
> --- a/tools/perf/util/dwarf-aux.c
> +++ b/tools/perf/util/dwarf-aux.c
> @@ -1110,8 +1110,10 @@ int die_get_typename_from_type(Dwarf_Die *type_die, struct strbuf *buf)
>  	const char *tmp = "";
>  
>  	tag = dwarf_tag(type_die);
> -	if (tag == DW_TAG_array_type || tag == DW_TAG_pointer_type)
> +	if (tag == DW_TAG_pointer_type)
>  		tmp = "*";
> +	else if (tag == DW_TAG_array_type)
> +		tmp = "[]";
>  	else if (tag == DW_TAG_subroutine_type) {
>  		/* Function pointer */
>  		return strbuf_add(buf, "(function_type)", 15);
> -- 
> 2.45.0.rc1.225.g2a3ae87e7f-goog
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
