Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D972248C8A4;
	Thu, 24 Sep 2026 15:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790264516; cv=none; b=fIjcuvgY2t1faulQAV1ZkDTSn/RNawUmO3tx//Qd6OqANhxQOsBj78Y4XsYjiibf0W8em3FaJfuTizxxsmZ6eQctNtP8pyEnaAwKvmRdYXcvuRwi46pSa6gXCPgyAsGJs+c2t4iDFn04MDVNOg9u23LS5MUZlvjonaTLxvGdCDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790264516; c=relaxed/simple;
	bh=EYOzGhrk1cQRDYWCBxk5DFNvd+2AoIFiSMjKIW8jw2I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dsQd4VDAMUB800K/PxrHEa6WB9d6MDu2qqiz85Y7Q2DH80AeVYpdYkldpHX+q16K4bnCJuNcjp2IZmI3xkYvEo22C9SUo8aQRtki+CVnCOcUiFQ32X1oU7hoUQxPgvFTCdFN/U02DSvam27BXFdCI1us9lH2HIgGmxkZ8dvBpys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=ZKD11e4b; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="ZKD11e4b"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 467991E4D;
	Thu, 24 Sep 2026 08:41:50 -0700 (PDT)
Received: from localhost (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 600483F86F;
	Thu, 24 Sep 2026 08:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1790264513; bh=EYOzGhrk1cQRDYWCBxk5DFNvd+2AoIFiSMjKIW8jw2I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZKD11e4bnomsMJDUsU9g10tBzzsYHGGthfpkwNu37qzdhK/q+Lb78tVvd9LYjAEqY
	 RcXRcF3PbFNV1tCjKHgxKAUjuSC+3vyj88e25ZkX/aySxc+lURjzjlE/FrKWyJjVUr
	 37s+P/cN2A/pvCpJHCux1D5/5/drpnEc4QB1JP+s=
Date: Thu, 24 Sep 2026 16:41:51 +0100
From: Leo Yan <leo.yan@arm.com>
To: Ian Rogers <irogers@google.com>
Cc: acme@kernel.org, alice.mei.rogers@gmail.com,
	linux-perf-users@vger.kernel.org, namhyung@kernel.org,
	adrian.hunter@intel.com, dapeng1.mi@linux.intel.com,
	james.clark@linaro.org, leo.yan@linux.dev,
	linux-kernel@vger.kernel.org, mingo@redhat.com,
	peterz@infradead.org, tmricht@linux.ibm.com
Subject: Re: [PATCH v2 38/49] perf python: Port arm-cs-trace-disasm to perf
 module
Message-ID: <20260924154151.GM200420@e132581.arm.com>
References: <cover.1789966896.git.irogers@google.com>
 <f724b653476e2733c18b02268c57baaaa54870ba.1789966896.git.irogers@google.com>
 <20260923090007.GJ200420@e132581.arm.com>
 <CAP-5=fUn8hafFn_RJs0vgaZKmeGEvWqRwtC4arYrCgogETXUJQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fUn8hafFn_RJs0vgaZKmeGEvWqRwtC4arYrCgogETXUJQ@mail.gmail.com>

On Wed, Sep 23, 2026 at 06:40:57AM -0700, Ian Rogers wrote:

[...]

> > > @@ -44,8 +56,8 @@ branch_search='[[:space:]](bl|b(\.(eq|ne|cs|cc|mi|pl|vs|vc|hi|ls|ge|lt|gt|le|al)
> > >  if [ "$(id -u)" == 0 ] && [ -e /proc/kcore ]; then
> > >       echo "Testing kernel disassembly"
> > >       perf record -o ${perfdata} -e cs_etm//k --kcore -Se -m,64K -- touch $file > /dev/null 2>&1
> > > -     perf script -i ${perfdata} --itrace=b -s python:${script_path} -- \
> > > -             -d --stop-sample=2 -k ${perfdata}/kcore_dir/kcore 2> /dev/null > ${file}
> > > +     $PYTHON ${script_path} -i ${perfdata} --itrace=b -d --stop-sample=2 \
> > > +             -k ${perfdata}/kcore_dir/kcore 2> /dev/null > ${file}
> > >       grep -q -E ${branch_search} ${file}
> > >       echo "Found kernel branches"
> > >  else
> > > @@ -56,8 +68,8 @@ fi
> > >  ## Test user ##
> > >  echo "Testing userspace disassembly"
> > >  perf record -o ${perfdata} -e cs_etm//u -Se -m,64K -- touch $file > /dev/null 2>&1
> > > -perf script -i ${perfdata} --itrace=b -s python:${script_path} -- \
> > > -     -d --stop-sample=2 2> /dev/null > ${file}
> > > +perf inject --itrace=b -i ${perfdata} -o ${perfdata2}
> > > +$PYTHON ${script_path} -i ${perfdata2} -d --stop-sample=2 2> /dev/null > ${file}
> >
> > The perf script command is replaced with perf inject and a Python
> > command. I learned from the above that we can pass the itrace option to
> > the Python script.
> >
> > This is fine with me. I'm just curious why we don't use a single Python
> > command here.
> 
> A single Python command that would handle both the itrace and file
> processing? We could. Having the script command also perform an
> inject-like rewrite of the data seemed less obvious to me than just
> having perf inject do the work and then running the script. It does
> mean a change for people using the script, and two commands could be
> less convenient than one. We could expand the Python module "session"
> code to include the ability to rewrite itrace data specifically for
> this script. I'm hoping that we can have more composable perf_tools in
> the code, similar to the ASLR code.

> It would be nice to add itrace support to the Python code with
> composing tools in mind. I was just putting off worrying about this
> for now.

Sorry for the confusion. I should have made this clearer in my previous
reply.

I was referring to this change:

+     $PYTHON ${script_path} -i ${perfdata} --itrace=b -d --stop-sample=2 \
+             -k ${perfdata}/kcore_dir/kcore 2> /dev/null > ${file}

If itrace processing is not currently supported by the Python code,
wouldn't adding --itrace=b here break the test?

Thanks,
Leo
