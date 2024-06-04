Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B5BC28DC7;
	Tue,  4 Jun 2024 22:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717540363; cv=none; b=Xw4WMQyeyg+k8r8j99/5x22ijiT/oyu6pQ6/B/HNWkQYTMuuinZgxwQ0kJfzXszqkY56c/4IEFQ5AMohIEMCmuNGInizAOJqFOnALy3Z+joO25GS6ABj7WTdpxS1EiPDaoA3MhKUxc7fOxodwa8CON5TcZsxszvKF8I1c/4ykCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717540363; c=relaxed/simple;
	bh=XawMJtdC0qHgow9/zyc4Nni1uO2svRHYtADfu3hnoWI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CFIscfxCO4MzctH/fdmjDrQyaT7wcSsH9jjZ89bizZ52SbhMUOZUPKkuVtY1SwivgmyMG8rczFK5h6J2Ix0Twdt99+n+MSyc5iuETOmSnWmH6OwN3IvOe0O5JehFARReqV340gx5uQCO7fmxRWwhDi6jECvWMYR/TA1RcLEkm4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QRaLms9k; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QRaLms9k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30E12C2BBFC;
	Tue,  4 Jun 2024 22:32:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717540362;
	bh=XawMJtdC0qHgow9/zyc4Nni1uO2svRHYtADfu3hnoWI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QRaLms9k6A4CkEPEk2PU+qCVJ52xV1IF278xkHuy+0o9CVRnMFrM3CH/6oYEE/qGw
	 OiLmpPGBmtuFJZPuw44WE6u7DUFvLKLYJcRAQT4zrnR3o3BDqT375VCopEGSfWKFmm
	 lTrLXF0J3ifQ8XNEC06u8tFkLDoWcROBTeHNul0Kl95cYsGDuEMLiVpaCCJ7riJ6sn
	 OsX8PU93nAlGXcO0JXtny9U2dCpmVZtGNiY97HgHY4YuwYMhr7gRb86eSF3rQ0x/kc
	 1WCYaZolZixoot8BftAN06Ff2y3BBW3w7PAXSw7e79eQ7rMYpgkngllYzHe7WKy7/L
	 o6oRPy+UpOUkA==
Date: Tue, 4 Jun 2024 15:32:40 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: "Wang, Weilin" <weilin.wang@intel.com>, Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	"Hunter, Adrian" <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Taylor, Perry" <perry.taylor@intel.com>,
	"Alt, Samantha" <samantha.alt@intel.com>,
	"Biggers, Caleb" <caleb.biggers@intel.com>
Subject: Re: [RFC PATCH v10 3/8] perf stat: Fork and launch perf record when
 perf stat needs to get retire latency value for a metric.
Message-ID: <Zl-WCEhhxBtiGGhn@google.com>
References: <20240529064327.4080674-1-weilin.wang@intel.com>
 <20240529064327.4080674-4-weilin.wang@intel.com>
 <CAM9d7cgSwZ3PU3H9VNvxQakocEZ_CQEqB9M1o3xTMdJ7F1sufQ@mail.gmail.com>
 <CO6PR11MB56357F58D99B17CD08671A26EEFC2@CO6PR11MB5635.namprd11.prod.outlook.com>
 <CAM9d7cjbHzgfW2fKQkZ2=gtEMD9N5wG4xaWgPU+N-YvmfhXviQ@mail.gmail.com>
 <CO6PR11MB563511F1A6165F0F4B30C4DFEEF82@CO6PR11MB5635.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CO6PR11MB563511F1A6165F0F4B30C4DFEEF82@CO6PR11MB5635.namprd11.prod.outlook.com>

On Tue, Jun 04, 2024 at 08:00:26PM +0000, Wang, Weilin wrote:

> > On Thu, May 30, 2024 at 11:46 PM Wang, Weilin <weilin.wang@intel.com>
> > > > > +       /*
> > > > > +        * Only set retire_latency value to the first CPU and thread.
> > > > > +        */
> > > > > +       if (cpu_map_idx == 0 && thread == 0) {
> > > > > +       /* Lost precision when casting from double to __u64. Any
> > > > improvement? */
> > > >
> > > > As I said before I think you can set t->val * 1000 and then
> > > > set the evsel->scale to 1e3 or 1e-3.
> > >
> > > Hi Namhyung,
> > >
> > > Sorry if this is a repeated message. I thought I replied to your suggestion
> > > on this last time. I'm thinking we should keep it like this for now and make
> > > this change unless we find the precision loss is critical. Because I thought
> > > we don't want to add special code to handle the calculation and final print
> > > to keep code simple.
> > >
> > > I kept this comment here so that we don't forget about it. Please let me
> > > know if you'd like me to remove it.
> > 
> > Please see print_counter_aggrdata().  It's the generic code to print
> > the event value and it'll display the value multiplied by the scale
> > (default to 1.0).  So you can keep precision as long as you set the
> > scale properly (1e-3).
> 
> I could see the retire_latency is printed correctly after set the evsel->scale to 1e-3
> and multiply the t->val * 1000. However, this scale is not used in metric calculations. 
> We need to add code in metric calculation or display part to scale it as well. Is that 
> acceptable or do you have other suggestions? 

Hmm.. I don't know if other metric already dealt with the scale like with
RAPL events.. If not, I think it's reasonable to add that to the metric
calculation.

Ian, what do you think?

Thanks,
Namhyung

