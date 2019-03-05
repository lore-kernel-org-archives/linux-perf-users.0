From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH v2 0/7] perf script python: add Python3 support
Date: Tue, 5 Mar 2019 11:55:49 +0200
Message-ID: <ef75a243-cf15-b763-8aeb-387f105377c6@intel.com>
References: <20190302011903.2416-1-tonyj@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190302011903.2416-1-tonyj@suse.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Jones <tonyj@suse.de>, linux-kernel@vger.kernel.org
Cc: acme@kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Feng Tang <feng.tang@intel.com>, Tom Zanussi <tzanussi@gmail.com>, Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>
List-Id: linux-perf-users.vger.kernel.org

On 2/03/19 3:18 AM, Tony Jones wrote:
> This is v2 of my version of the patchset.  Incorporating the 
> previous feedback.  Some changes from v1 were already merged.
> 
> Patch 1/7 deals with the existing inconsistent indentation.
> Indentation is now consistent per file but varying styles (tabs,
> 4 spaces and 8 spaces).   
> I will followup at a later date with changes to checkpatch to ensure
> that the syntax per file is maintained.
> 
> Patches 2/7 through 5/7 were sent in v1,  they have been changed 
> to remove the previous indentation changes
> 
> Patch 6/7 was sent in v1.  I had previously *not* been able to test 
> export-to-postgresql.py.  I was able to do so this time and found
> that more changes were needed.    The author of the original code
> seems concerned about code-style so I would suggest you only merge 
> with his explicit ACK.
> 
> Patch 7/7 was not in v1, it cleans up some repeated use of date
> functions in the SQL exporters.  It is not mandatory for Python3
> support.  It is dependent on Patch#6.
> 
> I hope I've got everything correct, I've retested until I feel I 
> can't look at Python code anymore for a while :-). Hopefully I've 
> not made any more mistakes.  If I have, please LMK and I'll do v3.

perf tools link against python2 so have the scripts been tested with python3?

$ ldd tools/perf/perf | grep python
        libpython2.7.so.1.0 => /usr/lib/x86_64-linux-gnu/libpython2.7.so.1.0
(0x00007ff8a2de2000)
