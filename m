From: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Subject: Re: [PATCH v2 6/7] perf script python: add Python3 support to sql
 scripts
Date: Thu, 7 Mar 2019 15:51:42 -0300
Message-ID: <20190307185142.GA32240@kernel.org>
References: <20190302011903.2416-1-tonyj@suse.de>
 <20190302011903.2416-7-tonyj@suse.de>
 <7353b42e-ea14-e044-adfe-5a9705bf030c@intel.com>
 <72ea2e3d-1b82-549e-741f-d2b532e4c33b@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <72ea2e3d-1b82-549e-741f-d2b532e4c33b@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Jones <tonyj@suse.de>
Cc: Adrian Hunter <adrian.hunter@intel.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>
List-Id: linux-perf-users.vger.kernel.org

Em Wed, Mar 06, 2019 at 08:32:42AM -0800, Tony Jones escreveu:
> On 3/6/19 1:26 AM, Adrian Hunter wrote:
> > On 2/03/19 3:19 AM, Tony Jones wrote:
> >> Support both Python2 and Python3 in the exported-sql-viewer.py,
> >> export-to-postgresql.py and export-to-sqlite.py scripts
> >>
> >> There may be differences in the ordering of output lines due to
> >> differences in dictionary ordering etc.  However the format within lines
> >> should be unchanged.
> >>
> >> The use of 'from __future__' implies the minimum supported Python2 version
> >> is now v2.6
> >>
> >> Signed-off-by: Tony Jones <tonyj@suse.de>
> >> Signed-off-by: Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>
> >> Cc: Adrian Hunter <adrian.hunter@intel.com>
> > 
> > Apart from one issue (see below), it looks good, thank you!
> > 
> >> ---
> >>  tools/perf/scripts/python/export-to-postgresql.py | 65 +++++++++++++++--------
> >>  tools/perf/scripts/python/export-to-sqlite.py     | 23 ++++----
> >>  tools/perf/scripts/python/exported-sql-viewer.py  | 42 ++++++++++-----
> >>  3 files changed, 84 insertions(+), 46 deletions(-)
> >>
> >> diff --git a/tools/perf/scripts/python/export-to-postgresql.py b/tools/perf/scripts/python/export-to-postgresql.py
> >> index 390a351d15ea..439bbbf1e036 100644
> >> --- a/tools/perf/scripts/python/export-to-postgresql.py
> >> +++ b/tools/perf/scripts/python/export-to-postgresql.py
> >> @@ -10,6 +10,8 @@
> >>  # FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> >>  # more details.
> >>  
> >> +from __future__ import print_function
> >> +
> >>  import os
> >>  import sys
> >>  import struct
> >> @@ -199,6 +201,16 @@ import datetime
> >>  
> >>  from PySide.QtSql import *
> >>  
> >> +if sys.version_info < (3, 0):
> >> +	def tobytes(str):
> >> +		return str
> >> +else:
> >> +	def tobytes(str):
> >> +		# Use latin-1 (ISO-8859-1) so all code-points 0-255 will result
> >> +		# in one byte (note utf-8 is 2 bytes for values > 128 and
> >> +		# ascii is limited to values <= 128)
> >> +		return bytes(str, "ISO-8859-1")
> > 
> > Probably this should be the server_encoding, but python2 allowed UTF-8
> > so let's just use UTF-8 for now.  That will also mean doing the conversion
> > before getting the len(), otherwise len() can be wrong.
> 
> I'm not totally understanding what you're saying here.  The rationale for 
> using latin-1 and not UTF-8 was clearly expressed in the comment.  Else you 
> do indeed run into length issues.
> 
> Would it be easier, since you have a) more familiarity with the code b) some
> specific issues I'm not fully understanding if you just took this patch and
> made the changes you want yourself.  I doubt I'll ever use these scripta, my
> interest is purely in eliminating Python2 as a fixed requirement.

Adrian, can you please reply here? I'm not familiar with this tobytes()
python2/python3 difference, what do you mean about using
'server_encoding'? Where is that defined?

- Arnaldo
