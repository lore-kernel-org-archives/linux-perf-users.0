From: Tony Jones <tonyj@suse.de>
Subject: Re: [PATCH] perf tools: update docs regarding kernel/user space
 unwinding
Date: Fri, 27 Mar 2020 13:09:34 -0700
Message-ID: <20200327200934.GB2715@suse.de>
References: <20200325164053.10177-1-tonyj@suse.de>
 <38ba2caa-dadd-52c4-c6ea-5e01b7e59ee2@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <38ba2caa-dadd-52c4-c6ea-5e01b7e59ee2@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Clarke <pc@us.ibm.com>
Cc: linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>, linux-kernel@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

On Thu, Mar 26, 2020 at 04:32:26PM -0500, Paul Clarke wrote:
> > +		and 'lbr'.  The value 'dwarf' is effective only if libunwind
> > +		(or a recent version of libdw) is present on the system;
> > +		the value 'lbr' only works for certain cpus. The method for
> > +		kernel space is controlled not by this option but by the
> > +		kernel config (CONFIG_UNWINDER_*).
> 
> Your changes are just copying the old text, so this isn't a criticism of your patches.
> 
> Do we have information to replace "a recent version of libdw", which will quickly get stale?

Hi Paul.

The original "(libunwind or a recent version of libdw)" text was from Feb 2016.   So a while ago.

bd0419e2a5a9f requires >= 0.157 but this is for probing.  0a4f2b6a3ba50 specifies >= 0.158 but I see no mention of 
why in the commit but since it's from 2014 and elfutils is now at 0.178,  I think it's safe to just remove the 
reference.

As an aside, there is a lot of detail in perf-config.txt that's available in some of the other subcomands help files.
Seems a good way for things to get stale.   It could also do with some grammatical cleanup.

Tony
