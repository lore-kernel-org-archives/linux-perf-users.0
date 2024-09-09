Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6481758F;
	Mon,  9 Sep 2024 16:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725900644; cv=none; b=HvHlyx6175U7BfZEof3w8LDqpGBwt9cfxUmqLkqXyuUdnfNlhwekal2ZxvkeyI/gtJFDg0t9ED/bWHtT8f7RUlzjsl/IlBgPrrYALyoR1DrsxZK9dNDF1H1rpG2JkOVAoDMcpS4GTKk+VSxtNNexUH1dLX1dBVuB9VRSTJ9Izic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725900644; c=relaxed/simple;
	bh=tsHYHAglC2N91wzrIXaHd+3oArT6Uv0VkqBALZWibIM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Us6Y1NwzOnM4DkdKyk4pFqlCmk9D6iprtN7sZ5z1Qe0gfsLtKAzx9g950ctbQKK+hLNc28PCvUp8mOMrlmfrZDqhKYgZ81oHCjyNF+z9b+R3CBK/2YIGEz5unX/vJGtR9yLtABrG3Ax091yLZ55CrJj9HuxFRnVOunZ//RALQBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NER6Tu4e; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NER6Tu4e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DDC0C4CEC5;
	Mon,  9 Sep 2024 16:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725900643;
	bh=tsHYHAglC2N91wzrIXaHd+3oArT6Uv0VkqBALZWibIM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NER6Tu4ekT0kS05ta0vIBgiSGLbOUoGJLKP0/75wdv+rJMHBhzyBcDq3vR11G+S+4
	 d6F7Y3JSXWWZJlRbTsfH2r3xKN2COzof+aRFsNZ4VXHmnH9fqK2UNGS+nyaFUe6BQc
	 Mwjz1idSxyH616dCRIyxgbR5IzlvV0CINWRjvN6WAxeO8YsXrtNDqtvDhx5hVH7eIN
	 nk1xMS4Fl2a1+5OwpgJfCPqs82MUNTEoD2MT/vZTcpHV66gmCXUdD+4tnjm57n75dF
	 8+W+r02OaYDb9iYjEsGglVGPf1cuU0lMXfGna/wGmjp7aEbczNzJbdVd5bLs/Idvp/
	 362tpLt+ydNgw==
Date: Mon, 9 Sep 2024 13:50:40 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Howard Chu <howardchu95@gmail.com>
Cc: adrian.hunter@intel.com, irogers@google.com, jolsa@kernel.org,
	kan.liang@linux.intel.com, namhyung@kernel.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH v3 5/8] perf trace: Pretty print buffer data
Message-ID: <Zt8nYG3_24Eal4-y@x1>
References: <20240824163322.60796-1-howardchu95@gmail.com>
 <20240824163322.60796-6-howardchu95@gmail.com>
 <Zt8jTfzDYgBPvFCd@x1>
 <Zt8mMB7rkgSY1VSD@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zt8mMB7rkgSY1VSD@x1>

On Mon, Sep 09, 2024 at 01:45:41PM -0300, Arnaldo Carvalho de Melo wrote:
> On Mon, Sep 09, 2024 at 01:33:17PM -0300, Arnaldo Carvalho de Melo wrote:
> > >  static bool trace__filter_duration(struct trace *trace, double t)
> > >  {
> > >  	return t < (trace->duration_filter * NSEC_PER_MSEC);
> > > @@ -1956,6 +1987,8 @@ syscall_arg_fmt__init_array(struct syscall_arg_fmt *arg, struct tep_format_field
> > >  		    ((len >= 4 && strcmp(field->name + len - 4, "name") == 0) ||
> > >  		     strstr(field->name, "path") != NULL))
> > >  			arg->scnprintf = SCA_FILENAME;
> > > +		else if (strstr(field->type, "char *") && strstr(field->name, "buf"))
> > > +			arg->scnprintf = SCA_BUF;

> > You can't really do this for things like 'read' as we would be printing
> > whatever is in the buffer when we enter the syscall, right? As we can
> > see testing after applying the following patch:
 
> This is also valid for the struct dumper, where I'll have to add some
> indication in the syscall_fmt table when the pointer should be read in
> the BPF augmenter, and thus we shouldn't bother to get it in the
> sys_enter if it is, say, fstat().

BTW, what I have so far, without addressing this last comment about the
struct pretty printing/collection is at the tmp.perf-tools-next branch:

⬢[acme@toolbox perf-tools-next]$ git log --oneline perf-tools-next/perf-tools-next..
14053de1be2bf3b1 (HEAD -> perf-tools-next, x1/perf-tools-next, perf-tools-next/tmp.perf-tools-next, acme/tmp.perf-tools-next) perf trace: Collect augmented data using BPF
3f060c2fe93b8298 perf trace: Pretty print buffer data
01ca0102b80c7b5c perf trace: Pretty print struct data
bb0819cf7392b797 perf trace: Add trace__bpf_sys_enter_beauty_map() to prepare for fetching data in BPF
6b22c2b502a1c21b perf trace: Use a common encoding for augmented arguments, with size + error + payload
5d9cd24924f57066 perf trace augmented_syscalls.bpf: Move the renameat aumenter to renameat2, temporarily
⬢[acme@toolbox perf-tools-next]$

⬢[acme@toolbox perf-tools-next]$ git remote -v | grep ^perf-tools-next
perf-tools-next	https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git (fetch)
perf-tools-next	https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git (push)
⬢[acme@toolbox perf-tools-next]$
 
- Arnaldo
