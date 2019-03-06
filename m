From: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Subject: Re: [PATCH v2 5/7] perf script python: add Python3 support to
 intel-pt-events.py
Date: Wed, 6 Mar 2019 18:12:56 -0300
Message-ID: <20190306211256.GQ30734@kernel.org>
References: <20190302011903.2416-1-tonyj@suse.de>
 <20190302011903.2416-6-tonyj@suse.de>
 <6fe06c75-5f98-4829-e139-af2bfcda24f3@intel.com>
 <dfa719d4-0d9e-ad08-536f-17b3da116b19@suse.de>
 <18913237-75f2-731b-940d-1fccc43d1b4a@suse.de>
 <fd26acf9-0c0f-717f-9664-a3c33043ce19@suse.de>
 <d3920c9a-3990-6111-ca4f-58d96a929bf4@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <d3920c9a-3990-6111-ca4f-58d96a929bf4@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Tony Jones <tonyj@suse.de>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>
List-Id: linux-perf-users.vger.kernel.org

Em Wed, Mar 06, 2019 at 11:28:35AM +0200, Adrian Hunter escreveu:
> On 5/03/19 6:19 PM, Tony Jones wrote:
> > On 3/5/19 8:10 AM, Tony Jones wrote:
> > 
> >>
> >> Sure enough, I managed to attach the wrong patch. Sorry. I'll attach revised (v3) 
> >> to this thread as the change is trivial.
> > 
> > From: Tony Jones <tonyj@suse.de>
> > Date: Tue, 05 Mar 2019 08:31:30 -0800
> > Subject: [PATCH v3] perf script python: add Python3 support to intel-pt-events.py
> > 
> > Support both Python2 and Python3 in the intel-pt-events.py script
> > 
> > There may be differences in the ordering of output lines due to
> > differences in dictionary ordering etc.  However the format within lines
> > should be unchanged.
> > 
> > The use of 'from __future__' implies the minimum supported Python2 version
> > is now v2.6
> > 
> > Signed-off-by: Tony Jones <tonyj@suse.de>
> > Signed-off-by: Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>
> > Cc: Adrian Hunter <adrian.hunter@intel.com>
> 
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>

Thanks, applied.
