From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH 0/6] Fix issues with Python3 scripting
Date: Thu, 24 Jan 2019 11:39:22 +0100
Message-ID: <20190124103922.GB13852@krava>
References: <20190124005229.16146-1-tonyj@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190124005229.16146-1-tonyj@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Jones <tonyj@suse.de>
Cc: linux-kernel@vger.kernel.org, Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>, Ravi Bangoria <ravi.bangoria@linux.ibm.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Jonathan Corbet <corbet@lwn.net>, linux-perf-users@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

On Wed, Jan 23, 2019 at 04:52:23PM -0800, Tony Jones wrote:
> Seeteena posted, earlier this week, some patches to add Python3 support
> to scripts/python/*.py.  Unfortunately there were some issues with these
> patches (such as: https://lkml.org/lkml/2019/1/17/351)
> 
> Since I already had a tested set of patches in openSUSE:Factory and 
> SLE15-SP1 and was about to submit them, Seeteena and I that agreed I 
> should post my patches not involving scripts/python/*.py and Seeteena 
> will later resubmit the patches for scripts/python/*.py incorporating 
> my review feedback under a joint signed-off-by.
> 
> It should be noted that the use of "from __future__ import print_function" 
> (see: https://lkml.org/lkml/2019/1/16/641) and "except as" (see change to:
> tests/attr.py) implies Python2 >= 2.6 as the necessary support has not 
> been backported to prior versions.  I am not sure if it's worth detecting 
> <2.6 at build time or whether it's sufficiently old as to be a non-issue?
> 
> The shebang changes were driven mostly by our build process as it scans
> all files within an rpm and the shebangs would result in a rpm requires
> on the python2 binary when BuildRequires was python3-devel. I think they 
> make sense to apply upstream but understand totally if it's prefered we 
> keep them local.
> 
> These changes have been tested with PYTHON=python2 (v2.7) and 
> PYTHON=python3 (v3.6) on latest openSUSE Tumbleweed.  I did notice that 

please try latest code from Arnaldo, we just had fix in that area

> test #18 "'import perf' in python" is failing on my system without these 
> changes. I'll look at it further but didn't want to hold up Seeteena's 
> resubmit.
> 
> Tony Jones (6):
>   perf script python: Add trace_context extension module to sys,modules
>   perf script python: Use PyBytes for attr in trace-event-python
>   perf script python: remove explicit shebang from setup.py
>   perf script python: remove explicit shebang from tests/attr.c
>   perf script python: remove explicit shebang from Python scripts
>   perf script python: add Python3 support to tests/attr.py

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka
