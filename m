From: Tony Jones <tonyj@suse.de>
Subject: [PATCH 2/6] perf script python: Use PyBytes for attr in trace-event-python
Date: Wed, 23 Jan 2019 16:52:25 -0800
Message-ID: <20190124005229.16146-3-tonyj@suse.de>
References: <20190124005229.16146-1-tonyj@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190124005229.16146-1-tonyj@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>, Ravi Bangoria <ravi.bangoria@linux.ibm.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Jonathan Corbet <corbet@lwn.net>, linux-perf-users@vger.kernel.org, Tony Jones <tonyj@suse.de>, =?UTF-8?q?Jaroslav=20=C5=A0karvada?= <jskarvad@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

With Python3.  PyUnicode_FromStringAndSize is unsafe to call on attr and will
return NULL.  Use _PyBytes_FromStringAndSize (as with raw_buf).

Below is the observed behavior without the fix.  Note it is first necessary
to apply the prior fix (Add trace_context extension module to sys,modules):

# ldd /usr/bin/perf | grep -i python
        libpython3.6m.so.1.0 => /usr/lib64/libpython3.6m.so.1.0 (0x00007f8e1dfb2000)

# perf record -e raw_syscalls:sys_enter /bin/false
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.018 MB perf.data (21 samples) ]

# perf script -g python | cat
generated Python script: perf-script.py

# perf script -s ./perf-script.py
in trace_begin
Segmentation fault (core dumped)

Signed-off-By: Tony Jones <tonyj@suse.de>
Cc: Jaroslav Škarvada <jskarvad@redhat.com>
Fixes: 66dfdff03d196e51322c6a85c0d8db8bb2bdd655
---
 tools/perf/util/scripting-engines/trace-event-python.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
index 40300d8e80a7..777c97b13905 100644
--- a/tools/perf/util/scripting-engines/trace-event-python.c
+++ b/tools/perf/util/scripting-engines/trace-event-python.c
@@ -733,8 +733,7 @@ static PyObject *get_perf_sample_dict(struct perf_sample *sample,
 		Py_FatalError("couldn't create Python dictionary");
 
 	pydict_set_item_string_decref(dict, "ev_name", _PyUnicode_FromString(perf_evsel__name(evsel)));
-	pydict_set_item_string_decref(dict, "attr", _PyUnicode_FromStringAndSize(
-			(const char *)&evsel->attr, sizeof(evsel->attr)));
+	pydict_set_item_string_decref(dict, "attr", _PyBytes_FromStringAndSize((const char *)&evsel->attr, sizeof(evsel->attr)));
 
 	pydict_set_item_string_decref(dict_sample, "pid",
 			_PyLong_FromLong(sample->pid));
-- 
2.20.1
